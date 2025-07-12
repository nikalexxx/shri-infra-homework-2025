# Stage 1: Build
FROM node:20 as builder

WORKDIR /app

# Копируем только package.json и package-lock.json для кэширования зависимостей
COPY package*.json ./

# Установка всех зависимостей (включая devDependencies)
RUN npm ci

# Копируем исходники
COPY . .

# Выполняем сборку проекта
RUN npm run build


# Stage 2: Run
FROM node:20-alpine

WORKDIR /app

# Копируем только необходимые файлы из первой стадии
COPY --from=builder /app/package*.json ./
COPY --from=builder /app/dist ./dist

# Устанавливаем только production зависимости
RUN npm ci --only=production

# Пробрасываем порт, если сервер слушает его
EXPOSE 3000

# Команда запуска приложения
CMD ["node", "dist/server/index.js"]