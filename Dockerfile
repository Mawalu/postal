FROM ruby:2.3

COPY . /opt/postal/
VOLUME /opt/postal/config
VOLUME /opt/postal/app/public
WORKDIR /opt/postal

ENV LOG_TO_STDOUT 1
ENV AM_CONFIG_ROOT /opt/postal/config

RUN gem install procodile
RUN apt-get update -qq && apt-get install -yqq nodejs libcap2-bin
RUN bundle

RUN useradd -r -m -d /opt/postal -s /bin/bash postal
RUN setcap 'cap_net_bind_service=+ep' /usr/local/bin/ruby

USER postal

