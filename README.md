# worldmap-migration
Worldmap Database migrations....written in pure shell

Usage
=====


1. Make sure to load the sql dump.

	psql -U $DB_USER -c "CREATE DATABASE $OLD_DB"

	psql -U $DB_USER -d $OLD_DB < $SQL_DUMP_PATH


2. Run migration scripts

	chmod +x main.sh
	source main.sh -d $OLD_DB

**Notes**

- Make sure you have loaded your database dump.

- Make sure you have the geoserver styles tables within files.
