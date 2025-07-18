# Stage 1: Build the application
FROM node:18-alpine AS builder
WORKDIR /app
COPY package*.json ./
COPY . .
#RUN npm install --save-dev @tailwindcss/postcss
#RUN npm ci --only=production
RUN npm install
RUN npm ci
COPY . .
RUN npm run build 

# Stage 2: Serve the application
FROM node:18-alpine
WORKDIR /app
ENV NODE_ENV production
COPY --from=builder /app/package*.json ./
COPY --from=builder /app/node_modules ./node_modules
COPY --from=builder /app/lib ./lib  
COPY --from=builder /app/public ./public
COPY --from=builder /app/src ./src


EXPOSE 3000
CMD ["next", "build"]
CMD ["npm","run","build"]
CMD ["npm", "start"]
