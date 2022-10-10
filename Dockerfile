FROM node:14-slim

# setup okteto message
WORKDIR /opt/app
COPY package*.json ./
COPY prisma ./prisma/
COPY .env ./

RUN apt-get update && apt-get -y install openssl
RUN yarn install
COPY . ./

# COPY index.js .
RUN npx prisma migrate dev
EXPOSE 3002

CMD [  "yarn", "start", "start:migrate:dev" ]

