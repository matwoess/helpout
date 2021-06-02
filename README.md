# helpout

A community solidarity app.

# setup
1. start postgresql service
2. update postgresql to current base population with the import of the backup found in ./db (preferably in pgAdmin)
3. create user "helpout" (password: "helpout") in pgAdmin and give him all possible rights (all switches on yes/on)
4. open postgrest in ./rest via command line interface (Linux users might download own executable)
	=> command: "postgrest.exe postgresql.conf"
5. test: request data from endpoint (in our case mostly http://localhost:3000 ) and do a curl command on /user  