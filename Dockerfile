FROM debian:jessie

ENV RUBY_VERSION 1.8.7-p374
ENV PATH /usr/local/rvm/gems/ruby-${RUBY_VERSION}/bin:/usr/local/rvm/gems/ruby-${RUBY_VERSION}@global/bin:/usr/local/rvm/rubies/ruby-${RUBY_VERSION}/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/local/rvm/bin

RUN set -ex \
 && apt-get update && apt-get install -y curl \
 && gpg --keyserver hkp://keys.gnupg.net --recv-keys 409B6B1796C275462A1703113804BB82D39DC0E3 \
 && curl -sSL https://get.rvm.io | bash -s stable --ruby=${RUBY_VERSION}
