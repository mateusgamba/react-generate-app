FROM node:10.15.1-alpine

WORKDIR /usr/app/

COPY package*.json ./

RUN yarn install --silent