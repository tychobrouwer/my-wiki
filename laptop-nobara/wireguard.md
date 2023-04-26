# Wireguard

[Back](./README.md)

## Configure Wireguard (Method 1)

Create the wg0 wireguard configuration ```/etc/wireguard/wg0.conf```

```(shell)
[Interface]
PrivateKey = WIREGUARD_PRIVATE_KEY
Address = 10.6.0.3/32
DNS = 192.168.178.101

[Peer]
PublicKey = WIREGUARD_PUBLIC_KEY
AllowedIPs = 10.6.0.0/24, 192.168.178.0/24
Endpoint = WIREGUARD_ENDPOINT
PersistentKeepalive = 21
```

Enable the service with wg-quick

```(shell)
systemctl enable wg-quick@wg0
systemctl start wg-quick@wg0
```

Fix resolvconf permissions if necessary

```(shell)
chmod 0755 /usr/sbin/resolvconf.openresolv
```

## Configure Wireguard (Method 2)

Open the network manager GUI

```(shell)
nm-connection-editor
```

Configure a new Wireguard VPN with

```(shell)
Interface name:  wg0
Private key:     PRIVATE_KEY
Listen port:     automatic
Fwmark:          off
MTU:             automatic
Add peer routes: true
```

Add a peer with

```(shell)
Public key:           PRIVATE_KEY
Allowed IPs:          10.6.0.0/24,192.168.178.0/24
Endpoint:             WIREGUARD_IP:51820
Persistent keepalive: 21
```

For the IPv4 settings

```(shell)
DNS: 192.168.178.101
```

Add address

```(shell)
Address: 10.6.0.3
Netmask: 32
Gateway: 0.0.0.0
```

In the general section select ```Connect automatically with priority```.
