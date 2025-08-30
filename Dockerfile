# ---- Stage 1: Build the frontend ----
FROM node:18-alpine AS build
WORKDIR /app

# Copy package.json from devops-build/
COPY devops-build/package*.json ./
RUN npm install --frozen-lockfile

# Copy the rest of the source code
COPY devops-build/ ./

# Build React app
RUN npm run build

# ---- Stage 2: Serve with Nginx ----
FROM nginx:alpine
COPY --from=build /app/build /usr/share/nginx/html
EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]
