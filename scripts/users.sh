#############################################################################
# Migration for users table
#############################################################################

sudo -u $USER PGPASSWORD=$DB_PW \
psql -v ON_ERROR_STOP=1 -U $DB_USER -h $DB_HOST $OLD_DB -c \
    "COPY(SELECT DISTINCT auth_user.id,
        auth_user.password,
        auth_user.last_login,
        auth_user.is_superuser,
        auth_user.username,
        auth_user.first_name,
        auth_user.last_name,
        auth_user.email,
        auth_user.is_staff,
        auth_user.is_active,
        auth_user.date_joined,
        maps_contact.organization,
        maps_contact.position,
        maps_contact.voice,
        maps_contact.fax,
        maps_contact.delivery,
        maps_contact.city,
        maps_contact.area,
        maps_contact.zipcode,
        maps_contact.country
    FROM auth_user, maps_contact
    WHERE maps_contact.user_id = auth_user.id) to stdout with csv" | \
sudo -u $USER psql $NEW_DB -c \
    "COPY people_profile (id,
        password,
        last_login,
        is_superuser,
        username,
        first_name,
        last_name,
        email, 
        is_staff,
        is_active,
        date_joined,
        organization,
        position,
        voice,
        fax,
        delivery,
        city,
        area,
        zipcode,
        country)
    FROM STDIN CSV"

#############################################################################

echo "\nReset user sequence"; do_dash
sudo -u $USER psql $NEW_DB -c \
    "SELECT setval(pg_get_serial_sequence('people_profile', 'id'),
        coalesce(max(id),0) + 1, false)
    FROM people_profile;"