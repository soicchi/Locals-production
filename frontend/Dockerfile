FROM node:16.13.1-alpine

ENV LANG=C.UTF-8 \
    TZ=Asia/Tokyo \
    GOOGLE_API_KEY=$GOOGLE_API_KEY

WORKDIR /frontend
COPY . /frontend

RUN yarn install \
    && yarn build

EXPOSE 80