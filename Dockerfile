# === Этап 1: Сборщик (Builder) ===
# Используем стабильную версию Node.js для сборки проекта
FROM node:22.9.0-alpine AS builder

# Устанавливаем рабочую директорию
WORKDIR /app

# Копируем package.json и package-lock.json для установки зависимостей
COPY package*.json ./

# Устанавливаем "чистые" зависимости, идеально для CI/CD
RUN npm ci

# Копируем все остальные файлы проекта
COPY . .

# Собираем клиентский и серверный код
RUN npm run build


# === Этап 2: Исполнитель (Runner) ===
# Используем тот же образ, но начнем с чистого листа
FROM node:22.9.0-alpine

WORKDIR /app

# Копируем только необходимые для запуска артефакты из сборщика
COPY --from=builder /app/package*.json ./
COPY --from=builder /app/node_modules ./node_modules
COPY --from=builder /app/dist ./dist

# Открываем порт, на котором будет работать приложение
EXPOSE 3000

# Команда для запуска приложения
CMD ["npm", "start"]
