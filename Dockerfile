# Используем официальный образ Node.js
FROM node:20-alpine

# Устанавливаем зависимости
WORKDIR /app
COPY package*.json ./
RUN npm ci

# Копируем исходный код
COPY . .

# Собираем клиент
RUN npm run build

# Открываем порт 3000
EXPOSE 3000

# Запускаем сервер
CMD ["npm", "start"]