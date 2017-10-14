FROM ubuntu:16.04

RUN apt-get update
RUN apt-get install -y curl

# install NodeJS 6 LTS
RUN curl -sL https://deb.nodesource.com/setup_6.x | bash -
RUN apt-get install -y nodejs