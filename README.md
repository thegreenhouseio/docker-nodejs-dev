# docker-nodejs-dev
A [Docker][] image for [NodeJS][] development, primarily for the benefit of The Greenhouse by providing the best tools and developer experience.

[Docker]: https://www.docker.com/
[NodeJS]: https://nodejs.org/


## Features
| Tool | Version | Notes |
|------|---------|-------|
| [NodeJS][] | ^6.0.0  | This is the current LTS version |
| [Yarn][] | ^1.0.0  |       |
| [npm][] | ^1.0.0  |       |
| [Chrome Headless][] | N / A  |  Base image accounts for needed host packages needed to run Chrome Headless |

[NodeJS]: https://nodejs.org/en/download/
[npm]: https://www.npmjs.com/
[Yarn]: https://yarnpkg.com/en/
[Chrome Headless]: https://developers.google.com/web/updates/2017/04/headless-chrome

## Development
Common Docker commands, generally used in development

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
1. Test things out
1. Disconnect from the contaier `exit`
1. Destroy the container `docker rm nodejs-dev-app`

### Continuous Integration
[CircleCI](https://circleci.com/) is used to build the container on each PR.

## Publish Procedure
Below are the steps to publish a new release of the image, based on this [guide](https://docs.docker.com/docker-cloud/builds/push-images/)

1. Export environment variable - `export DOCKER_ID_USER="username"
1. Login - `docker login`
   * Hit Enter
   * Enter Password
1. Build the image `docker build -t nodejs-dev .`
1. Tag the image `docker tag nodejs-dev thegreenhouse/nodejs-dev`
1. Push the image `docker push thegreenhouse/nodejs-dev`
1. Check the image [exists](https://hub.docker.com/r/thegreenhouse/nodejs-dev/tags/) in Docker Hub
1. Create a git tag `git tag -a x.y.z -m "tagging x.y.z release"
1. Push the tag `git push origin master --tags`