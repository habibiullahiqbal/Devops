# #----------------------backend.Dockerfile----------------------
# # =========================
# # Stage 1: Base Build Stage
# # =========================
# FROM node:20 AS build

# # Set working directory inside container
# WORKDIR /app

# # Copy package files first to leverage Docker caching
# COPY package*.json ./

# # Install dependencies
# RUN npm install

# # Copy the rest of your project files
# COPY . .

# # =========================
# # Stage 2: Production Stage
# # =========================
# FROM node:20-alpine

# # Set working directory inside container
# WORKDIR /app

# # Copy only necessary files from build stage
# COPY --from=build /app /app

# # Set environment variables
# ENV NODE_ENV=production \
#     PORT=5010

# # Expose backend port
# EXPOSE 5010

# # Start the app
# CMD ["npm", "start"]
# #----------------------end of backend.Dockerfile----------------------


# #----------------------frontend.Dockerfile----------------------
# # Stage 1: Build Stage
# FROM node:22 AS build

# # Set the working directory
# WORKDIR /app

# # Copy package.json and package-lock.json (or yarn.lock)
# COPY package*.json ./

# # Install dependencies
# RUN npm ci

# # Copy the rest of the application code
# COPY . .


# # Build the application
# RUN npm run build

# # Stage 2: Production Stage (using Alpine for smaller image)
# FROM node:22-alpine AS production

# # Set the working directory
# WORKDIR /app

# # Copy only the build output and necessary files from the build stage
# COPY --from=build /app /app

# # Install only production dependencies
# RUN npm ci 

# # Expose the necessary port
# EXPOSE 3000

# # Command to start the application
# CMD ["npm", "run", "start"]
