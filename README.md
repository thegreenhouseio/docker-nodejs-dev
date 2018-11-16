# docker-nodejs-dev
A [Docker][] image for [NodeJS][] development, primarily for the benefit of The Greenhouse by providing the best tools and developer experience.
https://hub.docker.com/r/thegreenhouse/nodejs-dev/tags/

[Docker]: https://www.docker.com/
[NodeJS]: https://nodejs.org/

# Usage
In your own _Dockerfile_, use this project as your base image to get the full environment available to you.
```shell
FROM thegreenhouse/nodejs-dev:0.3.0
```

## Features
To see an example of this container being used for CI with all these features, see [create-evergreen-app](https://github.com/ProjectEvergreen/create-evergreen-app) (_.circleci/config.yml_).

### Environment
| Tool | Version | Notes |
|------|---------|-------|
| [NodeJS][] | 10.x  | This is the current LTS version |
| [Yarn][] | 1.x  |       |
| [npm][] | 6.x  |       |
| [Chrome Headless][] | N / A  |  Host packages needed to run **Chrome** Headless |
| [Chromium][] | Stable  |  Host packages needed to run **Chrome** browser (in headless mode) |
| [JRE][] | 8  |  Java Runtime Environment (needed by **Selenium**) |

[NodeJS]: https://nodejs.org/en/download/
[npm]: https://www.npmjs.com/
[Yarn]: https://yarnpkg.com/en/
[Chrome Headless]: https://developers.google.com/web/updates/2017/04/headless-chrome
[Chromium]: https://www.chromium.org/
[JRE]: http://www.oracle.com/technetwork/java/javase/downloads/jre8-downloads-2133155.html

### Command Line tools
The following command line tools are available
```shell
vim git bzip2 ssh build-essential
```

### Headless Chrome
Headless Chrome ([Puppetter]()) is available and for example can be used with [Karma](https://karma-runner.github.io/) by including this in _karma.conf.js_.

```javascript
browsers: ['CustomChromeHeadless'],
customLaunchers: {
  CustomChromeHeadless: {
    base: 'ChromeHeadless',
    flags: ['--no-sandbox', '--disable-setuid-sandbox'] // https://github.com/Googlechrome/puppeteer/issues/290#issuecomment-322852784
  }
},
captureTimeout: 210000, // https://github.com/jasmine/jasmine/issues/1413#issuecomment-334247097
browserDisconnectTolerance: 3,
browserDisconnectTimeout: 210000,
browserNoActivityTimeout: 210000,
```

### JRE (Selenium / Web Component Tester)
The Java Runtime Environment (JRE) is included for running tools like [Web Component Tester](https://github.com/Polymer/tools/tree/master/packages/web-component-tester#custom-environments) can use Chrome by including this in _wct.conf.json_.  This also supports running Selenium.

```javascript
{
  "plugins": {
    "local": {
      "disabled": true
    },
    "headless": {
      "browsers": [
        "chrome"
      ],
      "browsersOptions": {
        "chrome": [
          "window-size=1920,1080",
          "headless",
          "disable-gpu",
          "no-sandbox"
        ]
      }
    }
  }
}
```

## Development
Common Docker commands used for the local development of this project.

- `docker build -t some-tag-name .` - build a Docker image from the project's _Dockerfile_ with a name (`-t`)
- `docker run --name my-running-app -i -t some-tag-name` - start a Docker container from an image, giving it a name (`--name`).  The `-i` tag will connect you to the container automatically.
- `docker rm my-running-app` - destroy a running container
- `docker images` - list available images
- `docker ps` - list available (running) containers
- `exit` - quit a connection to a container

### Workflow
My general workflow for testing has looked something like:
1. Make changes to _Dockerfile_
1. Build the image `docker build -t nodejs-dev .`
1. Run and connect to the container `docker run --name nodejs-dev-app -i -t nodejs-dev`
1. Make a scratch space `mkdir workspace && cd workspace`
1. Clone a repo into the workspace `git clone https://github.com/thegreenhouseio/angular-webapp-seed.git`
1. Test things out, like `yarn install && yarn build`
1. Test another project (from the workspace) `npx create-evergreen-app my-app && cd my-app && npm install && npm run build && export NODE_ENV=production && npm test`
1. Disconnect from the contaier `exit`
1. Destroy the container `docker rm nodejs-dev-app`

### Continuous Integration
[CircleCI](https://circleci.com/) is used to build the container on each PR.  ([TODO](https://github.com/thegreenhouseio/docker-nodejs-dev/issues/18)) It run a scripts that's based on the above developer workflow
1. Clones a repo in the container
1. Installs dependencies
1. Runs unit tests
1. Runs the build

## Publish Procedure
Below are the steps to publish a new release of the image, based on this [guide](https://docs.docker.com/docker-cloud/builds/push-images/)

1. Export environment variable - `export DOCKER_ID_USER="username"`
1. Login - `docker login`
   * Hit Enter
   * Enter Password
1. Build the image `docker build -t nodejs-dev .`
1. Tag the image `docker tag nodejs-dev:latest thegreenhouse/nodejs-dev:x.y.z`
1. Push the image `docker push thegreenhouse/nodejs-dev:x.y.z`
1. Check the image [exists](https://hub.docker.com/r/thegreenhouse/nodejs-dev/tags/) in Docker Hub
1. Create a git tag `git tag -a x.y.z -m "tagging x.y.z release"`
1. Push the tag `git push origin master --tags`
