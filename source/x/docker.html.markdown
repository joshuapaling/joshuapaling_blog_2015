---
title: Docker
---

<h1>Docker</h1>

Container vs Virtual Machine: Containers share an OS, VMs don't.

Good article: [Intro to Containers, VMs and Docker](https://medium.freecodecamp.com/a-beginner-friendly-introduction-to-containers-vms-and-docker-79a9e3e119b#.1tgltv6co)

To run bash in a container:

`docker run -i -t <name-or-id> /bin/bash`

docker: Deals with single containers. When people say “Docker” they typically mean Docker Engine, the client-server application made up of the Docker daemon, a REST API that specifies interfaces for interacting with the daemon, and a command line interface (CLI) client that talks to the daemon (through the REST API wrapper). Docker Engine accepts docker commands from the CLI, such as docker run <image>, docker ps to list running containers, docker images to list images, and so on. (from [here](https://docs.docker.com/machine/overview/))

docker-machine: Don't think you need to use this if you're using docker-native: It's for dealing with a virtual machine that docker containers can run inside of. See [here](https://blog.docker.com/2016/03/docker-for-mac-windows-beta/) abnd search for docker-machine for more info.

docker-compose: deals with multiple containers connected together to form a more complex system.

Docker native doesn't mean that docker doesn't run in a VM. It just means that rather than using VirtualBox (or similar) to run the VM, it runs in a VM managed by docker native, which communicates directly with the Mac OSX hypervisor. So, it takes out VirtualBox as a middleman.

Docker containers still have an 'operating system' or linux distro installed on them. What they share with the underlying VM is the linux kernel, not the whole distro.

`docker ps`: list running containers.
`docker ps -a`: list ALL containers, even those not running.
`docker volume ls`: list all volumes
`docker volume rm <name>`: remove a volume

In the case of this error:

```
web_rails_1    | Could not find rake-11.2.2 in any of the sources
web_rails_1    | Run `bundle install` to install missing gems.
thebigvaultrails_web_rails_1 exited with code 7
```

Run bash in the container with

`docker-compose run web_rails /bin/bash`

And then `bundle install`

Still not sure why this error comes up? The gems should be installed as part of the docker image. I think that after changing gems in the web_rails image, or maybe just when rebuilding it, you need to do `docker-compose build sidekiq bundle`.

Think I've fixed it - added 'volumes_from' to the web_rails container.

So:

If you build the rails container stand-alone with `docker build .` the gems will be packaged up with that container - not on an external volume. If you do `docker-compose build



