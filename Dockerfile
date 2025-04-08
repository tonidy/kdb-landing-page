# Build stage
FROM node:22-alpine AS builder

WORKDIR /app

# Copy package files and install dependencies
COPY package*.json ./
RUN npm ci

# Copy the rest of the application code
COPY . .

# Build the application with static export
RUN npm run build

# Production stage
FROM nginx:alpine AS production

# Copy static files to nginx
COPY --from=builder /app/out /usr/share/nginx/html

# Add custom nginx configuration for SPA routing
RUN echo 'server { \
    listen 80; \
    location / { \
        root /usr/share/nginx/html; \
        index index.html index.htm; \
        try_files $uri $uri/ /index.html; \
    } \
}' > /etc/nginx/conf.d/default.conf

EXPOSE 80

CMD ["nginx", "-g", "daemon off;"]