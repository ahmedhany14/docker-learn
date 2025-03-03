# pull the node image with the latest tag
FROM node:latest

# set the working directory called app
WORKDIR /app

COPY package.json .

RUN npm install

EXPOSE 3000

COPY . .

VOLUME [ "/app/feedback" ]

CMD ["node", "server.js"]

