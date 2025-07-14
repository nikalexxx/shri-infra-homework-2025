# Базовый образ
FROM node:20-alpine

# Установка зависимостей
WORKDIR /app
COPY package*.json ./
RUN npm ci

# Копирование исходного кода
COPY . .

# Сборка приложения
RUN npm run build

# Запуск приложения
EXPOSE 3000
CMD ["npm", "start"]