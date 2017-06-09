#!/bin/bash

do_hr() {
   echo "==============================================================="
}

do_dash() {
   echo "---------------------------------------------------------------"
}

# Parsing inputs.
for i in "$@"
do
case $i in
    -t|--tables)
    TABLES=true
    shift # past argument with no value
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
do_hr
echo "Executing geonode migrations"
do_hr
#############################################################################

source $ENV_PATH/bin/activate
python $GEONODE_PATH/manage.py makemigrations
python $GEONODE_PATH/manage.py migrate account --noinput
python $GEONODE_PATH/manage.py migrate

#############################################################################
do_hr
echo "Creating default user for Admin"
do_hr
#############################################################################

echo "from geonode.people.models import Profile;
     Profile.objects.create_superuser('admin', 'admin@worldmap.com', 'admin')" | \
python $GEONODE_PATH/manage.py shell

python $GEONODE_PATH/manage.py loaddata fixtures/default_oauth_apps.json

# If there are only tables creation only.
if [ $TABLES ]; then
	exit
fi

#############################################################################
do_hr
echo "Migration for users table"
do_hr
#############################################################################

source users.sh

#############################################################################
do_hr
echo "Executing migration for layers tables"
do_hr
#############################################################################

source layers.sh

#############################################################################
do_hr
echo "Migration for maps tables"
do_hr
#############################################################################

source maps.sh

#############################################################################
do_hr
echo "Migration for auth tables"
do_hr
#############################################################################

source auth.sh

#############################################################################
do_hr
echo "Migration for styles tables"
do_hr
#############################################################################

source styles.sh
