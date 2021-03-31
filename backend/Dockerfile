FROM node:15

WORKDIR /usr/app

# Install some dependencies
COPY package*.json ./
RUN npm install

# Copy backend
COPY . .

# Set up a default command
# CMD [ "npm","start" ]