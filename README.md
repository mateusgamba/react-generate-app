# Creating a React application without installing Node.js

It is possible create a Reactjs application without needing install the Node.js, you just need to have Docker installed.

For this let's divide the process in 3 steps:

1. Create a Docker image and push to dockerhub;
2. Generate React application from the our Docker image;
3. Run our application using `Dockerfile` and `docker-compose`; that is Dockerize our React application

## 1st Step - Create Docker image

Create the Dockerfile file, copy and paste the following code:

> if you prefer you can use my image builed and skip to step 3

```
FROM node:10.15.1-alpine
LABEL maintainer="your-email" \
  author="your-name" \
  version="1.0" \
  description="Create a create-react-app application without installing Node.js"

RUN npm install -g create-react-app

WORKDIR /app
```

For building image execute the following command:

```
docker build -t {username}/react-generate-app .
```

and if you prefer you can push the imagem on [Dockerhub](https://hub.docker.com/), so use the same Docker ID as username to facilitate.

```
docker push {username}/react-generate-app
```

## 2nd Step - Generate React application

Now let's generate create-react-app application. This application must be create in another folder, e.g. myFirstAppDocker, so access myFirstAppDocker and execute the following command:

For Mac or Linux:

```
docker run -it -v ${PWD}:/app -p 3000:3000 --rm {username}/react-generate-app create-react-app .
```

and for Windows:

```
docker run -it -v %cd%:/app -p 3000:3000 --rm {username}/react-generate-app create-react-app .
```

_For use a Docker image ready, execute:_

```
docker run -it -v %cd%:/app -p 3000:3000 --rm mateusgamba/react-generate-app create-react-app .
```

## 3rd step - Run application

After generating the application let's create our Dockerfile e docker-compose files to running it.

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

Now just execute `docker-compose up -d`, after openning your browser and access [http://localhost:8080](http://localhost:8080)

It is simply and easy. I hope you enjoyed.

Thanks.
