# Используем официальный Node.js образ
FROM node:20-alpine AS build

WORKDIR /app

COPY package*.json ./
RUN npm ci

COPY . .
RUN npm run build

# Production image
FROM node:20-alpine
WORKDIR /app
COPY --from=build /app /app

ENV NODE_ENV=production
EXPOSE 3000

CMD ["npm", "start"] 