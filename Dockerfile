FROM node:current-alpine3.22

WORKDIR /app

COPY ./ ./

RUN npm ci
RUN npm run build
CMD ["npm", "run", "start"]
