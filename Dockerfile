FROM node:20-alpine
WORKDIR /app
COPY package*.json ./
RUN npm ci --omit=dev
COPY . .
RUN npm run build
ENV PORT=3000
EXPOSE 3000
CMD ["npm","start"]