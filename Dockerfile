FROM node:18-alpine AS build
WORKDIR /app
    
COPY package*.json ./
RUN npm ci 
    
COPY . .
RUN npm run build 
    
FROM node:18-alpine AS run
WORKDIR /app
    
COPY package*.json ./
RUN npm ci --only=production \
    && npm install -g ts-node
    
COPY --from=build /app/dist ./dist
COPY --from=build /app/src  ./src
COPY --from=build /app/tsconfig.* ./
    
ENV NODE_ENV=production
EXPOSE 3000
CMD ["ts-node", "src/server/index.ts"]
    