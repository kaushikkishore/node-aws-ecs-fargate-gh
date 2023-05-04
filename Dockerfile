# Use an official Node.js runtime as a parent image
FROM --platform=linux/amd64 node:18

# Set the working directory to /app
WORKDIR /app

# Copy package.json and package-lock.json to the container
COPY package*.json ./

# Install only production dependencies
RUN npm ci --production

# Copy the rest of the application code to the container
COPY . .

# Expose port 3000 for the application
EXPOSE 3000

# Set the NODE_ENV environment variable to "production"
ENV NODE_ENV=production

# Start the application
CMD ["npm", "start"]
