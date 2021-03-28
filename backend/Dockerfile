FROM node:15

#Install some dependencies

WORKDIR /usr/app
COPY ./ /usr/app
RUN npm install

# Set up a default command
CMD [ "npm","start" ]