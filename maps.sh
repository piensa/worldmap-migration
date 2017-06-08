#############################################################################
# Migration for maps tables
#############################################################################

echo "\nGet current number of rows in resource base table"; do_dash
RESOURCE_COUNT=$(sudo -u $USER psql $NEW_DB -c "copy (SELECT MAX(id) FROM base_resourcebase) to stdout with csv")

#############################################################################

echo "\nDrop view augmented_maps_map"; do_dash
sudo -u $USER PGPASSWORD=$DB_PW \
psql -v ON_ERROR_STOP=1 -U $DB_USER -h $DB_HOST $OLD_DB -c "DROP VIEW augmented_maps_map"

#############################################################################

echo "\nCreating view augmented_maps_map"; do_dash
sudo -u $USER PGPASSWORD=$DB_PW \
psql -v ON_ERROR_STOP=1 -U $DB_USER -h $DB_HOST $OLD_DB -c \
	"CREATE OR REPLACE VIEW augmented_maps_map AS (SELECT $RESOURCE_COUNT + ROW_NUMBER() OVER (ORDER BY maps_map.id) as base_id, maps_map.* FROM maps_map)"

#############################################################################

echo "\nCopying elements into resourcebase table"; do_dash
sudo -u $USER PGPASSWORD=$DB_PW \
psql -v ON_ERROR_STOP=1 -U $DB_USER -h $DB_HOST $OLD_DB -c \
	"copy (select base_id, 'uuid', owner_id, title, last_modified, 'date_type', abstract, 'eng', 'supplemental_information', 'EPSG:4326', 'csw_typename', 'csw_schema', 'csw_mdsource', 'csw_type', 'csw_wkt_geometry', false, 0, 0, false, false, false, CONCAT('/maps/', base_id) from augmented_maps_map) to stdout with csv" | \
sudo -u $USER \
psql $NEW_DB -c 'copy base_resourcebase (id, uuid, owner_id, title, date, date_type, abstract, language, supplemental_information, srid, csw_typename, csw_schema, csw_mdsource, csw_type, csw_wkt_geometry, metadata_uploaded, popular_count, share_count, featured, is_published, metadata_uploaded_preserve, detail_url) from stdin csv'

#############################################################################

echo "\nCopy rows into maps_contactrole table"; do_dash
sudo -u $USER PGPASSWORD=$DB_PW \
psql -v ON_ERROR_STOP=1 -U $DB_USER -h $DB_HOST $OLD_DB -c \
	"copy (select * FROM (select maps_contactrole.id, augmented_maps_layer.id, maps_contact.user_id, maps_role.value from maps_contactrole inner join maps_role on maps_role.id = maps_contactrole.role_id left join augmented_maps_layer on augmented_maps_layer.id = maps_contactrole.layer_id inner join maps_contact on maps_contact.id = maps_contactrole.contact_id) as tables where user_id is not null) to stdout with csv" | \
sudo -u $USER \
psql $NEW_DB -c "copy base_contactrole (id, resource_id, contact_id , role) from stdin csv"

#############################################################################

echo "\nCopy rows into maps_map table"; do_dash
sudo -u $USER PGPASSWORD=$DB_PW \
psql -v ON_ERROR_STOP=1 -U $DB_USER -h $DB_HOST $OLD_DB -c \
	"copy (select base_id, title, abstract, zoom, projection, center_x, center_y, last_modified, urlsuffix, officialurl from augmented_maps_map) to stdout with csv" | \
sudo -u $USER \
psql $NEW_DB -c 'copy maps_map (resourcebase_ptr_id, title_en, abstract_en, zoom, projection, center_x, center_y, last_modified, urlsuffix, featuredurl) from stdin csv'

#############################################################################

echo "\nCopy rows into maps_maplayer table"; do_dash
sudo -u $USER PGPASSWORD=$DB_PW \
psql -v ON_ERROR_STOP=1 -U $DB_USER -h $DB_HOST $OLD_DB -c \
	"copy (select maps_maplayer.stack_order, maps_maplayer.format, maps_maplayer.name, maps_maplayer.opacity, maps_maplayer.styles, maps_maplayer.transparent, maps_maplayer.fixed, maps_maplayer.visibility, maps_maplayer.ows_url, maps_maplayer.layer_params, maps_maplayer.source_params, augmented_maps_map.base_id, true, maps_maplayer.group from augmented_maps_map, maps_maplayer WHERE augmented_maps_map.id = maps_maplayer.map_id) to stdout with csv" | \
sudo -u $USER \
psql $NEW_DB -c 'copy maps_maplayer (stack_order, format, name, opacity, styles, transparent, fixed, visibility, ows_url, layer_params, source_params, map_id, local, "group") from stdin csv'

#############################################################################

echo "\nCopy row into maps_mapsnapshot table"; do_dash
sudo -u $USER PGPASSWORD=$DB_PW \
psql -v ON_ERROR_STOP=1 -U $DB_USER -h $DB_HOST $OLD_DB -c \
	"copy (select maps_mapsnapshot.created_dttm, maps_mapsnapshot.config, augmented_maps_map.base_id, maps_mapsnapshot.user_id from maps_mapsnapshot, augmented_maps_map where augmented_maps_map.id = maps_mapsnapshot.map_id) to stdout with csv" | \
sudo -u $USER \
psql $NEW_DB -c 'copy maps_mapsnapshot (created_dttm, config, map_id, user_id) from stdin csv'

#############################################################################

echo "\nCopy row into wm_extra_mapstats table"; do_dash
sudo -u $USER PGPASSWORD=$DB_PW \
psql -v ON_ERROR_STOP=1 -U $DB_USER -h $DB_HOST $OLD_DB -c \
	"copy (select maps_mapstats.visits, maps_mapstats.uniques, maps_mapstats.last_modified, augmented_maps_map.base_id from maps_mapstats, augmented_maps_map where augmented_maps_map.id = maps_mapstats.map_id) to stdout with csv" | \
sudo -u $USER \
psql $NEW_DB -c 'copy wm_extra_mapstats (visits, uniques, last_modified, map_id) from stdin csv'

#############################################################################

echo "\nCopy django_guardian permissions"; do_dash
sudo -u $USER PGPASSWORD=$DB_PW psql -U $DB_USER -h $DB_HOST $OLD_DB -c \
	"copy(
		SELECT user_id, 56, CAST(augmented_maps_map.base_id AS VARCHAR) as resourcebase_id,
			CASE
		    	WHEN role_id=1 THEN unnest(array[166, 169, 171])
		    	WHEN role_id=2 THEN unnest(array[166, 167, 168, 169, 170, 171, 172, 173])
				WHEN role_id=3 THEN unnest(array[166, 167, 169, 171, 172, 173])
		    END AS permission_id
		FROM core_userobjectrolemapping, augmented_maps_map
		WHERE augmented_maps_map.id = core_userobjectrolemapping.object_id
			AND object_ct_id=20
	) to stdout with csv;" | \
sudo -u $USER psql $NEW_DB -c \
	"copy guardian_userobjectpermission(user_id, content_type_id, object_pk, permission_id)
		FROM STDIN CSV
	"
