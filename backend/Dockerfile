FROM node:16

WORKDIR /app

COPY package*.json ./
RUN npm install --production

COPY . .

COPY ./db_scripts /docker-entrypoint-initdb.d/

EXPOSE 5000
CMD ["node", "server.js"]