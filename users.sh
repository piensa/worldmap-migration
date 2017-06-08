#############################################################################
# Migration for users table
#############################################################################

sudo -u $USER PGPASSWORD=$DB_PW \
psql -v ON_ERROR_STOP=1 -U $DB_USER -h $DB_HOST $OLD_DB -c \
    "COPY(SELECT id,
        password,
        last_login,
        is_superuser,
        username,
        first_name,
        last_name,
        email,
        is_staff,
        is_active,
        date_joined
    FROM auth_user) to stdout with csv" | \
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
        date_joined)
    FROM STDIN CSV"

#############################################################################

echo "\nReset user sequence"; do_dash
sudo -u $USER psql $NEW_DB -c \
    "SELECT setval(pg_get_serial_sequence('people_profile', 'id'),
        coalesce(max(id),0) + 1, false)
    FROM people_profile;"