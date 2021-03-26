# Backend

## Prerequisites

- Node.js
- Node Package Manager(npm)
- Docker

## How to setup the environment

1. Go to the backend folder
1. Run `npm install` in the app directory
2. Run `npm start` to start dev server
3. Run `docker-compose up` to start the mongoDB server.\
*Note: Windows users use `docker-compose.exe up`*

## How to connect the database

The database is exposed on the port 27017.

You can use mongoDB compass to connect to the database(Recommended)

There is also a web app on localhost:5000 that can manage the database.(Not Recommended)
