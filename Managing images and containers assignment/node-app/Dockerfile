# pull the node image with the latest tag
FROM node:latest

# set the working directory called app
WORKDIR /app

# copy package.json in directory and install dependencies

COPY package.json .
RUN npm install

# copy rest of the files in the directory
COPY . .

# expose port 3000
EXPOSE 3000

# run the app at the start of the container
CMD ["node", "server.js"]