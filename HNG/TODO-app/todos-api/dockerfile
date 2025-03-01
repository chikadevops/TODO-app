FROM node:8-alpine3.10
WORKDIR /usr/src/app
COPY package*.json ./
RUN npm install
USER node
COPY . .
EXPOSE 8082
CMD ["node", "server.js"]