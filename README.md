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
- `docker images` - list available images
- `docker ps` - list available (running) containers
- `exit` - quit a connection to a container