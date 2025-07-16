FROM node:lts-alpine

COPY package*.json .

RUN npm ci

COPY . .

RUN npm run build:all

EXPOSE 3000

ENV NODE_ENV=production

CMD ["npm", "run", "start"]