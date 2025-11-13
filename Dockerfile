# Step 1: Build the app
FROM node:18-alpine AS build

WORKDIR /app
COPY package*.json ./
RUN npm install
COPY . .
RUN npm run build    # This will create a /build or /dist folder with static assets

# Step 2: Serve the built files
FROM node:18-alpine
WORKDIR /app
RUN npm install -g serve
COPY --from=build /app/build ./build  # Copy built files from the build stage

EXPOSE 3000
CMD ["serve", "-s", "build", "-l", "3000"]
