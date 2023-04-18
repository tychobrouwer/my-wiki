# **Wireguard**

[Back](./README.md)

## **Configure Wireguard**

Generate private key with

```(shell)
genkey | tee /etc/wireguard/private.key

chmod 0600 /etc/wireguard/private.key
```

Generate the public key for the private key

```(shell)
cat /etc/wireguard/private.key | wg pubkey | tee /etc/wireguard/public.key
```

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
