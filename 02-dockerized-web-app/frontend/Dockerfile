# Builder Stage 
FROM node:alpine AS builder

WORKDIR /app

# Copy only package files first for better caching
COPY package.json package-lock.json* ./

RUN npm ci 

# Copy the rest of the frontend source
COPY . .

# Build outputs to /app/dist
RUN npm run build

# Runtime Stage 
FROM nginx:alpine AS runtime

# Use our nginx config includes /api proxy
COPY nginx.conf /etc/nginx/conf.d/default.conf

# Clear default nginx html
RUN rm -rf /usr/share/nginx/html/*

# Copy built site into nginx web root
COPY --from=builder /app/dist /usr/share/nginx/html

EXPOSE 80