FROM node:18-slim

WORKDIR /usr/local/app

COPY . /usr/local/app

RUN npm install -g nodemon &&\
    npm ci &&\
    npm cache clean --force &&\
    mv /usr/local/app/node_modules /node_modules

EXPOSE 4000

CMD ["node", "server.js"]
