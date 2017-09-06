#!/bin/bash

do_hr() {
   echo "==============================================================="
}

do_dash() {
   echo "---------------------------------------------------------------"
}

OLD_DB=worldmap

# Parsing inputs.
for i in "$@"
do
case $i in
    -l|--local)
    LOCAL=true
    shift # past argument with no value
    ;;
    -t|--tables)
    TABLES=true
    shift # past argument with no value
    ;;
    -d|--database)
    OLD_DB="$2"
    shift # past argument
    ;;
    *)
            # unknown option
    ;;
esac
done

#############################################################################
do_hr
echo "Variables definitions"
do_hr
#############################################################################

source config.sh

# Settings all shell files as executables.
chmod +x *.sh

#############################################################################
do_hr
echo "Removing previous saved database"
do_hr
#############################################################################

if [ $(sudo -u $USER psql -l | grep $NEW_DB | wc -l ) = '1' ]
then 
	echo "Removing $NEW_DB"
	sudo -u $USER PGPASSWORD=$DB_PW psql -c "DROP DATABASE $NEW_DB;"
fi

#############################################################################
do_hr
echo "Create database $NEW_DB"
do_hr
#############################################################################
sudo -u $USER PGPASSWORD=$DB_PW psql -c "CREATE DATABASE $NEW_DB;"

sudo -u $USER PGPASSWORD=$DB_PW \
psql -v ON_ERROR_STOP=1 -U $DB_USER -h $DB_HOST -d $NEW_DB -c \
	"CREATE EXTENSION postgis;"

#############################################################################

if [ $LOCAL ]; then
do_hr
echo "Generating tables locally"
do_hr

source $ENV_PATH/bin/activate
python $GEONODE_PATH/manage.py makemigrations
python $GEONODE_PATH/manage.py makemigrations datatables certification
python $GEONODE_PATH/manage.py migrate

else
do_hr
echo "Generating tables from django"
do_hr

ssh wm-django-01 /bin/bash << EOF
source /home/ubuntu/wm.sh
python manage.py makemigrations
python manage.py makemigrations datatables certification
python manage.py migrate
EOF
fi

#############################################################################
do_hr
echo "Migration for users table"
do_hr
#############################################################################

source scripts/users.sh


python $GEONODE_PATH/manage.py loaddata fixtures/default_oauth_apps.json

# If there are only tables creation only.
if [ $TABLES ]; then
    exit
fi

echo "\ntaggit_tag table migration"; do_dash
sudo -u $USER PGPASSWORD=$DB_PW psql -U $DB_USER -h $DB_HOST $OLD_DB -c \
    "copy (
        select id,
               name,
               slug
        FROM taggit_tag)
        to stdout with csv" | \
sudo -u $USER psql $NEW_DB -c "copy taggit_tag (id, name, slug) from stdin csv"

#############################################################################
do_hr
echo "Executing migration for layers tables"
do_hr
#############################################################################

source scripts/layers.sh

#############################################################################
do_hr
echo "Migration for maps tables"
do_hr
#############################################################################

source scripts/maps.sh

#############################################################################
do_hr
echo "Migration for auth tables"
do_hr
#############################################################################

source scripts/auth.sh

#############################################################################
do_hr
echo "Gazetteer tables migration"
do_hr
#############################################################################

sudo -u $USER PGPASSWORD=$DB_PW \
psql -v ON_ERROR_STOP=1 -U $DB_USER -h $DB_HOST wmdata -c \
    "copy (SELECT layer_name, layer_attribute, feature_type, feature_fid, latitude, longitude, place_name, start_date, end_date, julian_start, julian_end, project, feature, username FROM gazetteer_gazetteerentry) to stdout with csv;" | \
sudo -u $USER \
psql $NEW_DB -c "copy gazetteer_gazetteerentry(layer_name, layer_attribute, feature_type, feature_fid, latitude, longitude, place_name, start_date, end_date, julian_start, julian_end, project, feature, username) from stdin csv"

#############################################################################
do_hr
echo "Migration for styles tables"
do_hr
#############################################################################

if [ -f $STYLES_PATH ]; then
    echo "Sql styles dump found..."
    source scripts/styles.sh
fi

#############################################################################
do_hr
echo "Migration for Harvard group"
do_hr
#############################################################################

sudo -u $USER PGPASSWORD=$DB_PW \
    psql -U $USER $NEW_DB -c "INSERT INTO auth_group(name) values('Harvard');"

GROUP_ID=$(sudo -u $USER psql $NEW_DB -c \
    "COPY (
        SELECT id FROM auth_group where name='Harvard')
    TO STDOUT WITH CSV")
sudo -u $USER PGPASSWORD=$DB_PW  \
    psql -v ON_ERROR_STOP=1 -U $DB_USER -h $DB_HOST $OLD_DB -c \
        "copy(SELECT user_id,$GROUP_ID FROM maps_contact WHERE is_harvard=true) to stdout with csv;" | \
sudo -u $USER PGPASSWORD=$DB_PW  \
psql $NEW_DB -c "copy people_profile_groups(profile_id,group_id) from stdin csv;"
