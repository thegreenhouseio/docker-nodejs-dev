FROM ubuntu:16.04

RUN apt-get update && apt-get install -y curl vim git bzip2 ssh build-essential

# install HeadlessChrome X11 packages
# https://github.com/Quramy/puppeteer-example#with-docker-based-ci-services
RUN apt-get install -yq gconf-service libasound2 libatk1.0-0 libc6 libcairo2 libcups2 libdbus-1-3 \
      libexpat1 libfontconfig1 libgcc1 libgconf-2-4 libgdk-pixbuf2.0-0 libglib2.0-0 libgtk-3-0 libnspr4 \
      libpango-1.0-0 libpangocairo-1.0-0 libstdc++6 libx11-6 libx11-xcb1 libxcb1 libxcomposite1 \
      libxcursor1 libxdamage1 libxext6 libxfixes3 libxi6 libxrandr2 libxrender1 libxss1 libxtst6 \
      ca-certificates fonts-liberation libappindicator1 libnss3 lsb-release xdg-utils wget

# install Chrome and Java JRE
# https://askubuntu.com/questions/510056/how-to-install-google-chrome
RUN wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | apt-key add 
RUN echo 'deb [arch=amd64] http://dl.google.com/linux/chrome/deb/ stable main' | tee /etc/apt/sources.list.d/google-chrome.list
RUN apt-get update && apt-get install -y google-chrome-stable default-jre

# install NodeJS LTS
RUN curl -sL https://deb.nodesource.com/setup_14.x | bash -
RUN apt-get install -y nodejs

# install latest yarn@1.0.0 and upgrade to latest release of npm@5.0.0
# use yarn to install npm \_(ツ)_/¯
# https://stackoverflow.com/questions/44269086/how-to-upgrade-npm-to-npm5-on-the-latest-node-docker-image
RUN npm install -g yarn@^1.10.0