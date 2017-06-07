#############################################################################
# Executing migration for layers tables
#############################################################################

echo "\nCreate view for bbox in legacy database"; do_dash
sudo -u $USER PGPASSWORD=$DB_PW \
psql -v ON_ERROR_STOP=1 -U $DB_USER -h $DB_HOST $OLD_DB -c \
    "CREATE OR REPLACE VIEW maps_layer_bbox AS
        SELECT id,
            CAST(bbox[1] AS float) AS bbox_x0,
            CAST(bbox[2] AS float) AS bbox_y0,
            CAST(bbox[3] AS float) AS bbox_x1,
            CAST(bbox[4] AS float) as bbox_y1
        FROM (SELECT id,
            string_to_array(replace(replace(replace(llbbox, ']',
            ''), '[',''), ',',''), ' ')
            AS bbox
    FROM maps_layer) AS seq"

#############################################################################

echo "\nCreate new layers table views with bbox in legacy database"; do_dash
sudo -u $USER PGPASSWORD=$DB_PW \
psql -v ON_ERROR_STOP=1 -U $DB_USER -h $DB_HOST $OLD_DB -c \
    "CREATE OR REPLACE VIEW augmented_maps_layer AS
        SELECT * FROM maps_layer
        INNER JOIN
            maps_layer_bbox USING (id) WHERE
                maps_layer_bbox.bbox_x0 > -181 AND
                maps_layer_bbox.bbox_x1 < 181 AND
                maps_layer_bbox.bbox_y0 > -91 AND
                maps_layer_bbox.bbox_y1 < 90"

#############################################################################

echo "\nGet layers content type needed for polymorphic"; do_dash
ID=$(sudo -u $USER psql $OLD_DB -c \
    "COPY (
        SELECT id FROM django_content_type WHERE name LIKE 'layer')
    TO STDOUT WITH CSV")

#############################################################################

echo "\nCopy items to resourcebase. Removing temporal extent fields
from previous database works"; do_dash
# ERROD: invalid input syntax for type timestamp with time zone: "0840"
# PGPASSWORD=$DB_PW psql -U $DB_USER -h $DB_HOST $OLD_DB -c "copy (select id, $ID, uuid, owner_id, title, date, date_type, abstract, language, supplemental_information, 'EPSG:4326', 'csw_typename', 'csw_schema', 'csw_mdsource', 'csw_type', 'csw_wkt_geometry', false, 0, 0, false, true, bbox_x0, bbox_y0, bbox_x1, bbox_y1, typename, false, temporal_extent_start, temporal_extent_end from augmented_maps_layer) to stdout with csv" | psql $NEW_DB -c "copy base_resourcebase (id, polymorphic_ctype_id, uuid, owner_id, title, date, date_type, abstract, language, supplemental_information, srid, csw_typename, csw_schema, csw_mdsource, csw_type, csw_wkt_geometry, metadata_uploaded, popular_count, share_count, featured, is_published, bbox_x0, bbox_y0, bbox_x1, bbox_y1, detail_url, metadata_uploaded_preserve, temporal_extent_start, temporal_extent_end) from stdin csv"
sudo -u $USER PGPASSWORD=$DB_PW \
psql -U $DB_USER -h $DB_HOST $OLD_DB -c "copy (select id, $ID, uuid, owner_id, title, date, date_type, abstract, language, supplemental_information, 'EPSG:4326', 'csw_typename', 'csw_schema', 'csw_mdsource', 'csw_type', 'csw_wkt_geometry', false, 0, 0, false, true, bbox_x0, bbox_y0, bbox_x1, bbox_y1, typename, false from augmented_maps_layer) to stdout with csv" | \
sudo -u $USER \
psql $NEW_DB -c "copy base_resourcebase (id, polymorphic_ctype_id, uuid, owner_id, title, date, date_type, abstract, language, supplemental_information, srid, csw_typename, csw_schema, csw_mdsource, csw_type, csw_wkt_geometry, metadata_uploaded, popular_count, share_count, featured, is_published, bbox_x0, bbox_y0, bbox_x1, bbox_y1, detail_url, metadata_uploaded_preserve) from stdin csv"

#############################################################################

echo "\nSet detail_url as /layers/typename"; do_dash
sudo -u $USER psql $NEW_DB -c \
    "UPDATE base_resourcebase SET detail_url = '/layers/'||detail_url;"

#############################################################################

echo "\nCopy items to base_topiccategory table"; do_dash
sudo -u $USER PGPASSWORD=$DB_PW \
psql -v ON_ERROR_STOP=1 -U $DB_USER -h $DB_HOST $OLD_DB -c \
    "COPY (SELECT id, name, title, description, true, 'fa_class' FROM maps_layercategory) TO STDOUT WITH CSV" | \
sudo -u $USER \
psql $NEW_DB -c "COPY base_topiccategory(id, identifier, description, gn_description, is_choice, fa_class) FROM stdin csv"

#############################################################################

echo "\nCopy items to layer table"; do_dash
sudo -u $USER PGPASSWORD=$DB_PW \
psql -v ON_ERROR_STOP=1 -U $DB_USER -h $DB_HOST $OLD_DB -c \
    'COPY (SELECT id, title, abstract, purpose, constraints_other, supplemental_information, data_quality_statement, workspace, store, "storeType", name, typename, name, false, false, false FROM augmented_maps_layer) to stdout with csv' | \
sudo -u $USER \
psql $NEW_DB -c 'COPY layers_layer (resourcebase_ptr_id, title_en, abstract_en, purpose_en, constraints_other_en, supplemental_information_en, data_quality_statement_en, workspace, store, "storeType", name, typename, charset, is_mosaic, has_time, has_elevation) from stdin csv'

#############################################################################

echo "\n Creating geowebcache url for layers"; do_dash
sudo -u $USER PGPASSWORD=$DB_PW \
psql -v ON_ERROR_STOP=1 -U $DB_USER -h $DB_HOST $NEW_DB -c \
    "copy (select resourcebase_ptr_id, 'tiles', 'Tiles', 'image/png', 'image', CONCAT('$GEOSERVER_URL', 'gwc/service/gmaps?layers=', typename, '&zoom={z}&x={x}&y={y}&format=image/png8') FROM layers_layer) to stdout with csv" | \
sudo -u $USER \
psql $NEW_DB -c "copy base_link(resource_id, extension, name, mime, link_type, url) from stdin csv"

#############################################################################

echo "\n Copy items to wm_extra_layerstats table"; do_dash
sudo -u $USER PGPASSWORD=$DB_PW \
psql -v ON_ERROR_STOP=1 -U $DB_USER -h $DB_HOST $OLD_DB -c \
    "copy (SELECT augmented_maps_layer.id, maps_layerstats.visits, maps_layerstats.uniques, maps_layerstats.downloads, maps_layerstats.last_modified FROM augmented_maps_layer, maps_layerstats WHERE augmented_maps_layer.id = maps_layerstats.layer_id) to stdout csv" | \
sudo -u $USER \
psql $NEW_DB -c "copy wm_extra_layerstats (layer_id, visits, uniques, downloads, last_modified) from stdin csv"

