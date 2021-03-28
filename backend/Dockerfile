FROM node:15

#Install some dependencies

WORKDIR /usr/src/app
COPY ./ /usr/src/app
RUN npm install

# Set up a default command
CMD [ "npm","start" ]