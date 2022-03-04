FROM node:16.13.1-alpine3.13

ENV LANG=C.UTF-8 \
    TZ=Asia/Tokyo \
    GOOGLE_API_KEY=$GOOGLE_API_KEY

WORKDIR /frontend

RUN apk add --no-cache autoconf automake file g++ libtool make nasm libpng-dev

COPY . /frontend

RUN yarn install \
    && yarn build

EXPOSE 80