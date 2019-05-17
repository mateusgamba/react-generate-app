# Creating a React application without installing Node.js

It is possible to create a Reactjs application without needing to install the Node.js, you just need to have Docker installed.

For this let's divide the process in 3 steps:

1. Create a Docker image and push to [Dockerhub](https://hub.docker.com/);
2. Generate React application from the our Docker image;
3. Run our application using `Dockerfile` and `docker-compose`; that is Dockerize our React application

## 1st Step - Creating Docker image

Create the Dockerfile file, copy and paste the following code:

> if you prefer you can [use an existing Docker image ](#using-an-existing-docker-image)

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

and if you prefer you can push the image on [Dockerhub](https://hub.docker.com/), so use the same Docker ID as username to facilitate.

```
docker push {username}/react-generate-app
```

## 2nd Step - Generating React application

Now let's generate create-react-app application. This application must be created in another folder, e.g. myFirstAppDocker, so access myFirstAppDocker and execute the following command:

For Mac or Linux:

```
docker run -it -v ${PWD}:/app -p 3000:3000 --rm {username}/react-generate-app create-react-app .
```

and for Windows:

```
docker run -it -v %cd%:/app -p 3000:3000 --rm {username}/react-generate-app create-react-app .
```

### Using an existing Docker image

You can use a ready Docker image for creating a React.js application, just execute:

```
docker run -it -v %cd%:/app -p 3000:3000 --rm mateusgamba/react-generate-app create-react-app .
```

## 3rd step - Running application

After generating the application let's create our Dockerfile e docker-compose files to running it.

[Dockerfile](https://github.com/mateusgamba/react-generate-app/blob/master/Dockerfile)

```
FROM node:10.15.1-alpine

WORKDIR /usr/app/

COPY package*.json ./

RUN yarn install --silent
```

[docker-compose.yml](https://github.com/mateusgamba/react-generate-app/blob/master/docker-compose.yml)

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

It is simple and easy. I hope you enjoy it.

Thanks.
