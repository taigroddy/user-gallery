FROM ruby:2.7.6

RUN apt-get update -qq && apt-get install -y nodejs postgresql-client && \
    apt-get install -y build-essential imagemagick file vim && \
    rm -rf /var/cache/apk/*

RUN apt-get update && apt-get install -y shared-mime-info libpq-dev vim

RUN mkdir /user-gallery
WORKDIR /user-gallery

COPY . /user-gallery
COPY ./Gemfile /user-gallery/Gemfile
COPY ./Gemfile.lock /user-gallery/Gemfile.lock

ENV BUNDLE_PATH=/bundle

RUN bundle install

EXPOSE 3000