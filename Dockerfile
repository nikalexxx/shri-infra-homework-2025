# Базовый образ Node.js
FROM node:20

# Рабочая директория
WORKDIR /app

# Копируем package.json и установим зависимости
COPY package*.json ./
RUN npm ci

# Копируем исходники
COPY . .

# Выполняем сборку проекта
RUN npm run build

# Пробрасываем порт
EXPOSE 3000

# Команда запуска приложения
CMD ["npm", "run", "start"]