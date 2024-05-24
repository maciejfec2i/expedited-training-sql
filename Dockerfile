FROM mysql:8.0

ENV MYSQL_ROOT_PASSWORD=password

# The MySQL image automatically runs scripts in /docker-entrypoint-initdb.d/ when initializing the database
COPY ./db/mysqlsampledatabase.sql /docker-entrypoint-initdb.d/