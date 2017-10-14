FROM ubuntu:16.04

RUN apt-get update
RUN apt-get install -y curl

# install NodeJS 6 LTS
RUN curl -sL https://deb.nodesource.com/setup_6.x | bash -
RUN apt-get install -y nodejs

# upgrade to latest release of npm@5.0.0
RUN npm install -g yarn@^1.0.0

# install latest yarn@1.0.0
RUN yarn global add npm@^5.0.0

# environment info
RUN node -v
RUN npm -v
RUN yarn -v