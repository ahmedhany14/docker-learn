# add node with version 14
FROM node:14

# create a working dir named app and open it

WORKDIR /app

# copy package file in the working dir and install dependencies

COPY package.json .

RUN npm install 

# copy all code there and run it

COPY . .

# expose port to 3000 in my host machine 

EXPOSE 3000

# run app 

CMD [ "node", "app.mjs" ]