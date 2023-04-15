FROM ruby:3.1.3-alpine
RUN apk update && apk add git
RUN apk add --update \ 
  build-base \
  mariadb-dev \
  sqlite-dev \ 
  nodejs \
  tzdata \
  && rm -rf /var/cache/apk/*

RUN gem install bundler

WORKDIR /app

COPY . /app
COPY Gemfile Gemfile.lock ./

RUN bundle install

EXPOSE 3000

CMD rm -f tmp/pids/server.pid & rails s -b '0.0.0.0'

