# Stage 1: Build the application
FROM node:18 AS builder
WORKDIR /app
COPY . .

# Stage 2: Run the application
FROM node:18-alpine
WORKDIR /app
# Copy only the necessary files from the builder stage
COPY --from=builder /app .
EXPOSE 3000
CMD ["node", "server.js"]