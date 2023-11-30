# Use an official Node.js runtime as the base image
FROM node:14-alpine as builder

# Set the working directory in the container
WORKDIR /app

# Copy package.json and package-lock.json to the working directory
COPY package.json .

# Install app dependencies
RUN npm install

# Copy the rest of the app's source code to the working directory
COPY . .

# Build your React app
RUN npm run build

FROM nginx
# Expose the port your app runs on
EXPOSE 80

COPY --from=builder /app/build /usr/share/nginx/html
