FROM ruby:3.0.3

ENV LANG=C.UTF-8 \
    TZ=Asia/Tokyo \
    DB_PASSWORD=$DB_PASSWORD \
    AWS_ACCESS_KEY_ID=$AWS_ACCESS_KEY_ID \
    AWS_SECRET_ACCESS_KEY=$AWS_SECRET_ACCESS_KEY \
    AWS_REGION=$AWS_REGION \
    DB_HOST=$DB_HOST \
    DB_NAME=$DB_NAME \
    DB_USERNAME=$DB_USERNAME \
    RAILS_MASTER_KEY=$RAILS_MASTER_KEY \
    API_DOMAIN=$API_DOMAIN

WORKDIR /app

RUN apt-get update -qq && apt-get install --no-install-recommends -y \
  node.js \
  yarn \
  imagemagick \
  && apt-get clean \
  && rm -rf /var/lib/apt/lists/*

COPY Gemfile* ./

RUN bundle install -j4

COPY . .
EXPOSE 3000