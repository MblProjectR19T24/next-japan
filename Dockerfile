# Stage 1: Build the application
FROM node:18-alpine AS builder
WORKDIR /app
COPY package*.json ./
COPY . .
#RUN npm install --save-dev @tailwindcss/postcss
#RUN npm ci --only=production
RUN npm ci
COPY . .
RUN npm run build  # Replace with your build command if different

# Stage 2: Serve the application
FROM node:18-alpine
WORKDIR /app
ENV NODE_ENV production
COPY --from=builder /app/package*.json ./
COPY --from=builder /app/node_modules ./node_modules
COPY --from=builder /app/lib ./lib # Replace /app/build with your output directory
COPY --from=builder /app/public ./public
COPY --from=builder /app/src ./src


EXPOSE 3000
CMD ["npm", "start"]  # Replace with your start command if different
