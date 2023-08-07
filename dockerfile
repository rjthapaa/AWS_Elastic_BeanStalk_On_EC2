# Official Node.js runtime as the base image for building app
FROM node:14-alpine as builder

# working directory in the container
WORKDIR /app
 
# Copy package.json and package-lock.json to the container
COPY package.json . 

# Install application dependencies
RUN npm install 

# Copy the rest of the application code to the container
COPY . . 

# Build the application
RUN npm run build

# Start a new stage for the Nginx runtime
FROM nginx 

# Expose port 80 for Nginx
EXPOSE 80 

# Copy the built application files from builder stage to Nginx container
COPY --from=builder /app/build /usr/share/nginx/html
