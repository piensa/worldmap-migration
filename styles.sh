#############################################################################
# Migration for styles tables
#############################################################################

sudo -u $USER PGPASSWORD=$DB_PW psql $NEW_DB -c \
	"copy layers_style (name, sld_title, sld_body, sld_version, sld_url, workspace) from '$GEOSERVER_STYLES_PATH/styles_geoserver.csv' WITH DELIMITER ',' CSV"

sudo -u $USER PGPASSWORD=$DB_PW psql $NEW_DB -c \
	"copy layers_layer_styles (layer_id,style_id) from '$GEOSERVER_STYLES_PATH/styles_layers.csv' WITH DELIMITER ' ' CSV"