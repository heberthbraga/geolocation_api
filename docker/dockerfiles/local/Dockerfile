FROM ruby:3.1.2-slim

ARG RAILS_ENV

RUN apt-get update -qq && apt-get install -yq --no-install-recommends \
  build-essential \
  gnupg2 \
  less \
  git \
  libpq-dev \
  postgresql-client \
  curl \
  && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

ENV LANG=C.UTF-8 \
  BUNDLE_JOBS=4 \
  BUNDLE_RETRY=3

RUN gem update --system && gem install bundler

WORKDIR /app

EXPOSE 3000

ENTRYPOINT ["./docker/dockerfiles/local/entrypoint.sh"]