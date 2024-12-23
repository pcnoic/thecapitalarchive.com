FROM alpine:latest AS build

RUN apk add --update hugo

WORKDIR /opt/src

COPY . .

RUN hugo

FROM nginx:1.25-alpine

COPY nginx.conf /etc/nginx/conf.d/default.conf

WORKDIR /usr/share/nginx/html

COPY --from=build /opt/src/public .

EXPOSE 3000/tcp

CMD ["nginx", "-g", "daemon off;"]
