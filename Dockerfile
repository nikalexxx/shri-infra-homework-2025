# Используем базовый образ Node.js
FROM node:22-alpine

# Указываем рабочую директорию
WORKDIR /app

# Копируем package.json и устанавливаем зависимости
COPY package*.json ./
RUN npm ci 

# Копируем исходный код приложения
COPY . .

# Собираем 
RUN npm run build

# Открываем порт, который будет слушать приложение
EXPOSE 3000

# Команда для запуска приложения
CMD ["npm", "start"]