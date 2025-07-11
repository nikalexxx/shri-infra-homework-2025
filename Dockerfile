# Используем официальный образ Node.js
FROM node:16-alpine as builder

# Устанавливаем рабочую директорию
WORKDIR /app

# Копируем package.json и package-lock.json
COPY package*.json ./

# Устанавливаем зависимости
RUN npm ci

# Копируем исходный код
COPY . .

# Собираем приложение
RUN npm run build

# Используем nginx для раздачи статики
FROM nginx:alpine

# Копируем собранные файлы из builder в nginx
COPY --from=builder /app/dist /usr/share/nginx/html 

# Копируем конфиг nginx
COPY nginx.conf /etc/nginx/conf.d/default.conf

# Открываем порт 80
EXPOSE 80

# Запускаем nginx
CMD ["nginx", "-g", "daemon off;"]