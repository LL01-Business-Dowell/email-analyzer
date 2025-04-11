# Use a specific node version instead of latest for stability
FROM node:20-slim

# Switch to root temporarily to set up directories
USER root

# Create and set working directory
WORKDIR /usr/src/app

# Copy package files
COPY package*.json ./

# Install production dependencies only
RUN npm ci --only=production && \
    chown -R node:node /usr/src/app/node_modules

# Copy application code
COPY . .
RUN chown -R node:node /usr/src/app

# Switch back to node user for security
USER node

# Expose the port
EXPOSE 80

# Set NODE_ENV
ENV NODE_ENV=production

# Start the application
CMD ["node", "index.js"]