# pull node image with latest tag
FROM node:latest

# set the working directory called app
WORKDIR /app

# copy all files from the current directory to the working directory
COPY . .

# install dependencies
RUN npm install

# expose port 3000
EXPOSE 3000

# run the app at the start of the container
CMD ["node", "server.js"]
