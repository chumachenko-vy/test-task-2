FROM node:16-alpine
WORKDIR /usr/src/app
COPY /home/volodymyr/test-task-2/package*.json ./
RUN npm install
COPY /home/volodymyr/test-task-2/ .
EXPOSE 8080
CMD [ "node", "server.js" ]
