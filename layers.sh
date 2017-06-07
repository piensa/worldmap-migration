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