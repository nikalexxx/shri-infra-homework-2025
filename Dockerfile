# Используем официальный Node.js образ
FROM node:22

# Создаём директорию приложения
WORKDIR /app

# Копируем файлы
COPY package*.json ./
COPY . .

# Устанавливаем зависимости
RUN npm ci

# Собираем проект
RUN npm run build

# Указываем порт
EXPOSE 3000

# Запускаем сервер
CMD ["npm", "start"]
