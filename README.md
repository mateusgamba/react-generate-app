# Generate your React application without installing Node.js

It is possible create a reactjs application without needing install the nodejs using docker

For this let's divide the process in 3 steps:

1. create a docker image and push to dockerhub
2. generate react application from the our docker image
3. run our application using dockerfile and docker-compose

## 1st Step

Create the Dockerfile file and copy and paste the following code:

```
FROM node:10.15.1-alpine
LABEL maintainer="youremail" \
  author="yourname" \
  version="1.0" \
  description="Create a create-react-app application without installing Node.js"

RUN npm install -g create-react-app

WORKDIR /app
```

Build your imagem

```
docker build -t {username-dockerhub}/react-generate-app .
```

and push your imagem for Dockerhub, it is necessary create an account on dockerhub

```
docker push {username-dockerhub}/react-generate-app
```

## 2nd Step

Now let's generate create-react-app application. This application must be created in other folder, e.g. myFirstAppDocker

For Mac or Linux:

```
docker run -it -v ${PWD}:/app -p 3000:3000 --rm {username-dockerhub}/react-generate-app create-react-app .
```

and for Windows:

```
docker run -it -v %cd%:/app -p 3000:3000 --rm {username-dockerhub}/react-generate-app create-react-app .
```

## 3rd step

After creating the application let's create our Dockerfile and docker-compose for running application.

Dockerfile

```
FROM node:10.15.1-alpine

WORKDIR /usr/app/

COPY package*.json ./

RUN yarn install --silent
```

docker-compose.yml

```
version: "2"
services:
    app:
        container_name: "my-first-app-docker"
        image: my-first-app-docker
        build: .
        command: ["yarn", "start"]
        ports:
            - 8080:3000
        volumes:
            - .:/usr/app/
            - /usr/app/node_modules
```
