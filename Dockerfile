FROM node:12-alpine as builder
WORKDIR /app
COPY package.json yarn.lock ./
RUN yarn
COPY . ./
RUN yarn build

FROM nginx:1-alpine
RUN mkdir -p /var/www/
COPY nginx.conf /etc/nginx/nginx.conf
COPY --from=builder /app/build /var/www/
