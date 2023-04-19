# Vivaldi

[Back](./README.md)

## Add Vivaldi YUM repo

Create YUM repo file ```/etc/yum.repos.d/vivaldi.repo``` with the contents

```(shell)
[vivaldi]
baseurl = https://repo.vivaldi.com/archive/rpm/x86_64/
gpgcheck = 0
name = vivaldi YUM repo
```

Install vivaldi

```(shell)
sudo dnf install vivaldi-stable
```
