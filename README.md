# Poker - Poquito Docker

Poker (Poquito Docker) is a bash implementation of Docker, making direct use of cgroups, namespaces, and overlay filesystem for creating and managing containers.

**Warning:** This should not be used in production systems

# Requirements

You need this packages installed for running poker

* chroot
* curl
* jq
* make
* skopeo
* tar
* docker ([temporarily for pulling images](https://github.com/manoloesparta/poker/issues/1))

# Commands

- [x] poker pull IMAGE_NAME [IMAGE_TAG]
- [x] poker images
- [x] poker rmi IMAGE_NAME [IMAGE_TAG]
- [x] poker run CONTAINER_NAME IMAGE_NAME [IMAGE_TAG]
- [x] poker ps
- [x] poker stop CONTAINER_NAME 
- [x] poker exec CONTAINER_NAME COMMAND
- [ ] poker build POKERFILE_PATH

# Features

- [x] Containers
- [ ] Networking
- [ ] Resource limiting
- [ ] Port forwarding
- [ ] Volumes
- [ ] Pokerfiles

# Helpful Resources

* [The Book of Kubernetes (Chapters 2 - 5)](https://nostarch.com/book-kubernetes)
* [Building a container from scratch in Go by Liz Rice](https://www.youtube.com/watch?v=Utf-A4rODH8)
* [Containers from scratch: The sequel by Liz Rice](https://www.youtube.com/watch?v=_TsSmSu57Zo)
* [What Are Namespaces and cgroups, and How Do They Work?](https://www.nginx.com/blog/what-are-namespaces-cgroups-how-do-they-work/)

# License

This project is under the MIT license
