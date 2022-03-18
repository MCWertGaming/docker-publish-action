# Docker publish plugin
This is a fully functional and battle-tested plugin for [DroneCI]() to automate docker build and push tasks. It focusses on compatibility with docker-ce on rhel8 / rockylinux 8 and convenience. Everything is customizable, but well configured out of the box.

This container was created to always feature the newest version of docker-ce of the official rhel8 repository. That allows you to easily build and push docker containers using a DroneCI runner operating on an rhel8 or rhel8 based host. Also it directly enables features like the docker buildkit and an easy configuration using environment variables.

## Usage
// official images are coming soon

## Building
This docker container can build itself, so why not making use of that? Building a custom version of this Drone plugin can be really helpful in secure environment, for example when you are using a private CA that has signed your docker registry.

### Building an initial version locally
After you have done your changes (or just don't trust the maintainer and want to take the container building into your own hands ;), you have to build and push the container into a docker registry. Drone will download the container from there later.

First make sure that you are logged in into your docker registry:
```
docker login <registry url>
```

Then we will build the initial container:
```
docker build . --pull --no-cache -t <destination url of your container>
```
> Note that you have you shell open in this repository to build the container.

This container is not that great due to the missing docker buildkit support, but it will work for the next step. We'll upload the container to your registry now:
```
docker push <destination url of your container>
```

When this worked you are ready to go. upload you changes to the git hosting service that is connected to your drone server and follow the steps described in [Usage](#usage) to build this plugin using itself.

## Contributing
Contributions are always welcome. It can be done in form of code contributions via PRs, reporting problems, bugs and improvements using issues and by simply using it and spreading the word! Thank you for using this project.

## License
This project is available under the terms of the MIT license. You are free to use this project for whatever you like to as long as you follow the license.
