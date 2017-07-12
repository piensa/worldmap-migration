#############################################################################
# Migration for auth tables
#############################################################################

echo "\nAuth_group table migration"; do_dash
sudo -u $USER PGPASSWORD=$DB_PW psql -U $DB_USER -h $DB_HOST $NEW_DB -c "UPDATE auth_group SET name = 'beta-users' WHERE id=1; INSERT INTO auth_group (name) VALUES ('dataverse');"

echo "\n people_profile_groups table migration"; do_dash
# sudo -u $USER PGPASSWORD=$DB_PW psql -U $DB_USER -h $DB_HOST $NEW_DB -c "TRUNCATE TABLE people_profile_groups;"

sudo -u $USER PGPASSWORD=$DB_PW \
psql -v ON_ERROR_STOP=1 -U $DB_USER -h $DB_HOST $OLD_DB -c \
	"copy (select id, user_id, group_id FROM auth_user_groups) to stdout with csv" | \
sudo -u $USER \
psql $NEW_DB -c "copy people_profile_groups (id, profile_id, group_id) from stdin csv"

#############################################################################

echo "\npeople_profile_user_permissions table migration"; do_dash
sudo -u $USER PGPASSWORD=$DB_PW \
psql -v ON_ERROR_STOP=1 -U $DB_USER -h $DB_HOST $OLD_DB -c \
	"copy (select id, user_id, permission_id FROM auth_user_user_permissions) to stdout with csv" | \
sudo -u $USER \
psql $NEW_DB -c "copy people_profile_user_permissions (id, profile_id, permission_id) from stdin csv"

#############################################################################

echo "\ndialogos_comment table migration"; do_dash
sudo -u $USER PGPASSWORD=$DB_PW \
psql -v ON_ERROR_STOP=1 -U $DB_USER -h $DB_HOST $OLD_DB -c \
	"copy (select id, author_id, name, email, website, content_type_id, object_id, comment, submit_date, ip_address, public FROM dialogos_comment) to stdout with csv" | \
sudo -u $USER \
psql $NEW_DB -c "copy dialogos_comment (id, author_id, name, email, website, content_type_id, object_id, comment, submit_date, ip_address, public) from stdin csv"

#############################################################################

echo "\ndjango_site table migration"; do_dash
sudo -u $USER PGPASSWORD=$DB_PW psql -U $DB_USER -h $DB_HOST $NEW_DB -c \
	"UPDATE django_site SET domain = 'worldmap.harvard.edu', name = 'Harvard WorldMap' WHERE id = 1"
