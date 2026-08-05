# =========================================================================
# STAGE 1: Build & Compile Vite Frontend Application
# =========================================================================
FROM node:20-alpine AS builder

WORKDIR /app

# Copy dependency definitions
COPY package*.json ./

# Install dependencies deterministically
RUN npm ci

# Copy source code & configuration
COPY . .

# Compile production bundle to /app/dist
RUN npm run build

# =========================================================================
# STAGE 2: High-Performance Nginx Web Server Production Stage
# =========================================================================
FROM nginx:1.25-alpine AS runner

# Remove default Nginx configuration
RUN rm /etc/nginx/conf.d/default.conf

# Copy custom Nginx configuration
COPY nginx.conf /etc/nginx/conf.d/default.conf

# Copy compiled static distribution from builder stage
COPY --from=builder /app/dist /usr/share/nginx/html

# Expose HTTP port 80
EXPOSE 80

# Healthcheck to verify web server responsiveness
HEALTHCHECK --interval=30s --timeout=5s --start-period=5s --retries=3 \
  CMD wget --quiet --tries=1 --spider http://localhost/ || exit 1

# Launch Nginx web server
CMD ["nginx", "-g", "daemon off;"]
