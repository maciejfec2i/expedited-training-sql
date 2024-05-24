# Expedited Training - SQL 

All of the resources used for delivering the SQL presentation to cover the SQL Expedited Training module.

Presentation covers the following topics:
- Introduction
  - What is SQL
  - Key Aspects of SQL
- Interactive Session
  - Introduction to Database
  - Join
  - Aggregation
  Pivots
- Summary
- Questions

## Technical Requirements
- Docker
- Optionally MySQL Workbench to make life easier when interacting with the database

## Database Setup
The MySQL server along with the sample database have been dockerised for the ease of setting up.

Run the following command in the directory containing the Dockerfile and the db directory with the mysqlsampledatabase.sql script to build a image:
```
docker build -t mysql-sample-db-img .
```

Run the following command to create the container for the MySQL database server along with a volume to presist the data along with any changes:
```
docker run -d --name mysql-sample-db -p 3306:3306 -v mysql-sample-db-vol:/var/lib/mysql mysql-sample-db-img
```

The custom container should now be running.

Use the following to stop the container
```
docker stop mysql-sample-db
```

Use the following command the start the container
```
docker start mysql-sample-db
```
