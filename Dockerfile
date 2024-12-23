FROM alpine:latest AS build

RUN apk add --update hugo

WORKDIR /opt/src

COPY . .

RUN hugo

FROM nginx:1.25-alpine

WORKDIR /usr/share/nginx/html

COPY --from=build /opt/src/public .

EXPOSE 80/tcp
