# Portainer

[Back](./README.md)

## Navigate

- [Install Packages](#install-packages)

- [Configure UFW Firewall](#configure-ufw-firewall)

- [Install Docker](#install-docker)

## Install and Configure Portainer

### Install Packages

Install the necessary packages

```(shell)
apt install ca-certificates curl gnupg ufw
```

### Configure UFW Firewall

Allow private CIDR blocks

```(shell)
ufw allow from 10.0.0.0/8
ufw allow from 172.16.0.0/12
ufw allow from 192.168.0.0/16
```

Allow [CloudFlare ip blocks](https://www.cloudflare.com/en-gb/ips) for port 80

```(shell)
ufw allow proto tcp from 103.21.244.0/22  to any port 80
ufw allow proto tcp from 103.22.200.0/22  to any port 80
ufw allow proto tcp from 103.31.4.0/22    to any port 80
ufw allow proto tcp from 10416..0.0/13    to any port 80
ufw allow proto tcp from 104.24.0.0/14    to any port 80
ufw allow proto tcp from 108.162.192.0/18 to any port 80
ufw allow proto tcp from 131.0.72.0/22    to any port 80
ufw allow proto tcp from 141.101.64.0/18  to any port 80
ufw allow proto tcp from 162.158.0.0/15   to any port 80
ufw allow proto tcp from 172.64.0.0/13    to any port 80
ufw allow proto tcp from 173.245.48.0/20  to any port 80
ufw allow proto tcp from 188.114.96.0/20  to any port 80
ufw allow proto tcp from 190.93.240.0/20  to any port 80
ufw allow proto tcp from 197.234.240.0/22 to any port 80
ufw allow proto tcp from 198.41.128.0/17  to any port 80
```

Enable firewall

```(shell)
ufw --force enable
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
