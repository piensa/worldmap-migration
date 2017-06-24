#############################################################################
# Migration for styles tables
#############################################################################

if [ ! -f $STYLES_PATH ]; then
	echo "no sql styles dump found...Exiting"
	exit 1
fi

#############################################################################

echo "\nSaving layers style from geoserver database dump"; do_dash
sudo -u $USER PGPASSWORD=$DB_PW \
psql -v ON_ERROR_STOP=1 -U $DB_USER -h $DB_HOST $NEW_DB -c \
	"copy layers_style (name, sld_title, sld_body, sld_version, sld_url, workspace)
	from '$STYLES_PATH' WITH DELIMITER ',' CSV"