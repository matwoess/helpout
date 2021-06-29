# helpout

A community solidarity app.

# Setup for local tests
## PostgreSQL + REST interface
1. start postgresql service
2. update postgresql to current base population with the import of the backup found in ./db (preferably in pgAdmin)
3. create user "helpout" (password: "helpout") in pgAdmin and give him all possible rights (all switches on yes/on)
4. update postgresql.conf file in ./rest to match the database settings
5. open postgrest in ./rest via command line interface (Linux and Mac users might download own executable)
	=> command: "postgrest.exe postgresql.conf" (on Windows, however, file extension might be changed for other systems)
5. test: request data from endpoint (in our case mostly http://localhost:3000 ) and do a curl command on /user 

## Serve website via python
1. Python allows serving a web application via the command line "python -m http.server 8000" in the folder ./web, which serves the sources to the address http:localhost:8000
