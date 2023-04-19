# Wireguard VPN

[Back](./README.md)

## Navigate

- [Install Packages](#install-packages)

- [Configure Wireguard](#configure-wireguard)

- [Install and Configure WG Dashboard](#install-and-configure-wg-dashboard)

## Install and Configure Wireguard VPN

### Install Packages

Install required packages for Wireguard

- iptables
- git
- wireguard

For Red Hat Wireguard package is named wireguard-tools.

```(shell)
apt install "package"
```

Install required python packages for Wireguard Dashboard

- ifcfg
- flask
- icmplib
- gunicorn
- flask_qrcode

```(shell)
pip3 install "package"
```

### Configure Wireguard

Set ip forwarding

```(shell)
sysctl -w net.ipv4.ip_forward=1
```

Set the wg0 configuration file ```/etc/wireguard/wg0.conf```

```(shell)
[Interface]
Address = 10.6.0.1/24
ListenPort = 51820
PrivateKey = PRIVATE_KEY

PostUp = iptables -A FORWARD -i %i -j ACCEPT; iptables -A FORWARD -o %i -j ACCEPT; iptables -t nat -A POSTROUTING -o eth0 -j MASQUERADE
PostDown = iptables -D FORWARD -i %i -j ACCEPT; iptables -D FORWARD -o %i -j ACCEPT; iptables -t nat -D POSTROUTING -o eth0 -j MASQUERADE

[Peer]
PublicKey = PUBLIC_KEY
AllowedIPs = 10.6.0.4/32

[Peer]
PublicKey = PUBLIC_KEY
AllowedIPs = 10.6.0.2/32
```

Enable and start wg0 service for VPN

```(shell)
systemctl start wg-quick@wg0.service
systemctl enable wg-quick@wg0.service
```

### Install and Configure WG Dashboard

Clone Wireguard Dashboard GitHub repository

```(shell)
cd /opt
git clone --depth 1 https://github.com/donaldzou/WGDashboard.git 
```

Install WG Dashboard

```(shell)
chmod +x /opt/WGDashboard/src/wgd.sh
/opt/WGDashboard/src/wgd.sh install
```

Configure WG Dashboard in ```/opt/WGDashboard/src/wg-dashboard.ini``` to

```(shell)
[Account]
username = admin
password = PASSWORD_HASH

[Server]
wg_conf_path = /etc/wireguard
app_ip = 192.168.178.102
app_port = 10086
auth_req = true
version = v3.0.6
dashboard_refresh_interval = 60000
dashboard_sort = status

[Peers]
peer_global_dns = 1.1.1.1
peer_endpoint_allowed_ip = 0.0.0.0/0
peer_display_mode = grid
remote_endpoint = 172.26.17.151
peer_mtu = 1420
peer_keep_alive = 21
```

Create WG Dashboard service file at ```/etc/systemd/system/wg-dashboard.service```

```(shell)
[Unit]
After=network.service

[Service]
WorkingDirectory=/opt/wg-dashboard/src
ExecStart=/usr/bin/python3 /opt/wg-dashboard/src/dashboard.py
Restart=always

[Install]
WantedBy=default.target
```

Start and enable WG Dashboard service

```(shell)
systemctl enable wg-dashboard
systemctl start wg-dashboard
```

</br>

[Top](#wireguard-vpn)
