# Portainer

[Back](./README.md)

## Navigate

- [Install Packages](#install-packages)

- [Install Docker](#install-docker)

## Install and Configure Portainer

### Install Packages

Install the necessary packages

```(shell)
apt install ca-certificates curl gnupg ufw
```

### Install Docker

Add the Docker GPG key to apt

```(shell)
wget -qO - https://download.docker.com/linux/debian/gpg | sudo apt-key add -
```

Add the Docker repository to the sources.list ```/etc/apt/sources.list```

```(shell)
deb https://download.docker.com/linux/debian bullseye stable
```

Install Docker

```(shell)
apt update && apt install docker-ce docker-ce-cli containerd.io
```

Start and enable Docker service

```(shell)
systemctl enable docker
systemctl start docker
```

Create Docker network for apps

```(shell)
docker network create web
```

Install the containers using Ansible.

</br>

[Top](#portainer)
