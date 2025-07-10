# Use Node.js 18 LTS as base image
FROM node:18-alpine

# Set working directory
WORKDIR /app

# Copy package files
COPY package*.json ./

# Install dependencies
RUN npm ci --only=production --silent

# Copy source code
COPY . .

# Install dev dependencies needed for build
RUN npm ci --silent

# Build the frontend
RUN npm run build

# Remove dev dependencies to reduce image size
RUN npm ci --only=production --silent && npm cache clean --force

# Expose port 3000
EXPOSE 3000

# Set environment variable for production
ENV NODE_ENV=production

# Start the application
CMD ["npm", "start"] 