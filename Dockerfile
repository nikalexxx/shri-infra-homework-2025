FROM node:lts-alpine

ENV PORT=3000

WORKDIR /usr/src/app

COPY ["package.json", "package-lock.json*", "npm-shrinkwrap.json*", "./"]

RUN npm ci --include=dev --prefer-offline --no-audit

COPY . .

RUN npm run build

ENV NODE_ENV=production
RUN npm ci --omit=dev --prefer-offline --no-audit && npm cache clean --force

EXPOSE 3000

RUN chown -R node /usr/src/app
USER node

CMD ["npm", "start"]
