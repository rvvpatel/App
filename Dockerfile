FROM node:10-alpine
RUN apk update && apk add openssh
RUN npm install -g @angular/cli

