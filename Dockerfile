# Remove named builder when you want to publish to AWS
# Declare builder phase
FROM node:10
WORKDIR "/app"
COPY package.json .
RUN yarn install
COPY . .
RUN yarn build

FROM nginx
USER root
ARG PORT
RUN echo $PORT
EXPOSE 80

# Copy from builder stage to build folder
# Replace builder with 0 when publishing AWS
COPY --from=0 /app/build /usr/share/nginx/html
COPY nginx.conf /etc/nginx/conf.d/default.conf

CMD sed -i -e 's/$PORT/'"$PORT"'/g' /etc/nginx/conf.d/default.conf && nginx -g 'daemon off;'

# To build: docker build -t web-prod
# To run the image: docker run -it -p 8080:80 web-prod