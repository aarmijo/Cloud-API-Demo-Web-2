# Use the official Node.js 18 Alpine image
FROM node:18-alpine

# Set the working directory
WORKDIR /app

# Increase Node.js memory limit if needed
ENV NODE_OPTIONS="--max-old-space-size=8192"

# Copy package files and install dependencies
COPY package*.json ./
RUN npm ci

# Copy source code
COPY . .

# Expose the port the app runs on (adjust this if your app uses a different port)
EXPOSE 3000

# Start the application using npm
CMD ["npm", "run", "serve"] 