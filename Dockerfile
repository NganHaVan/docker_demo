# Declare builder phase
FROM node:10 as builder 
WORKDIR "/app"
COPY package.json .
RUN yarn install
COPY . .
RUN yarn build

FROM nginx
# Copy from builder stage to build folder
COPY --from=builder /app/build /usr/share/nginx/html