# Remove named builder when you want to publish to AWS
# Declare builder phase
FROM node:10 as builder 
WORKDIR "/app"
COPY package.json .
RUN yarn install
COPY . .
RUN yarn build

FROM nginx
# Copy from builder stage to build folder
# Replace builder with 0 when publishing AWS
COPY --from=builder /app/build /usr/share/nginx/html

# To build: docker build -t web-prod
# To run the image: docker run -it -p 8080:80 web-prod