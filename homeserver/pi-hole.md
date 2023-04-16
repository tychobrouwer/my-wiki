# **Pi-Hole Unbound**

[Back](./README.md)

## **Navigate**

- [Install Unbound](#install-unbound)

- [Install Pi-Hole](#install-pi-hole)

## Install and Configure Pi-Hole and Unbound

### **Install Unbound**

```(shell)
apt install unbound
```

Configure unbound

```(shell)
mkdir /etc/unbound
mkdir /etc/unbound/unbound.conf.d
touch /etc/unbound/unbound.conf.d/pi-hole.conf
```

Set the file contents of ```/etc/unbound/unbound.conf.d/pi-hole.conf``` to

<details>
  <summary>Unbound configuration</summary>

```(shell)
server:
    # If no logfile is specified, syslog is used
    # logfile: "/var/log/unbound/unbound.log"
    verbosity: 0

    interface: 127.0.0.1
    port: 5335
    do-ip4: yes
    do-udp: yes
    do-tcp: yes

    # May be set to yes if you have IPv6 connectivity
    do-ip6: yes

    # You want to leave this to no unless you have *native* IPv6. With 6to4 and
    # Terredo tunnels your web browser should favor IPv4 for the same reasons
    prefer-ip6: no

    # Use this only when you downloaded the list of primary root servers!
    # If you use the default dns-root-data package, unbound will find it automatically
    #root-hints: "/var/lib/unbound/root.hints"

    # Trust glue only if it is within the server's authority
    harden-glue: yes

    # Require DNSSEC data for trust-anchored zones, if such data is absent, the zone becomes BOGUS
    harden-dnssec-stripped: yes

    # Don't use Capitalization randomization as it known to cause DNSSEC issues sometimes
    # see https://discourse.pi-hole.net/t/unbound-stubby-or-dnscrypt-proxy/9378 for further details
    use-caps-for-id: no

    # Reduce EDNS reassembly buffer size.
    # IP fragmentation is unreliable on the Internet today, and can cause
    # transmission failures when large DNS messages are sent via UDP. Even
    # when fragmentation does work, it may not be secure; it is theoretically
    # possible to spoof parts of a fragmented DNS message, without easy
    # detection at the receiving end. Recently, there was an excellent study
    # >>> Defragmenting DNS - Determining the optimal maximum UDP response size for DNS <<<
    # by Axel Koolhaas, and Tjeerd Slokker (https://indico.dns-oarc.net/event/36/contributions/776/)
    # in collaboration with NLnet Labs explored DNS using real world data from the
    # the RIPE Atlas probes and the researchers suggested different values for
    # IPv4 and IPv6 and in different scenarios. They advise that servers should
    # be configured to limit DNS messages sent over UDP to a size that will not
    # trigger fragmentation on typical network links. DNS servers can switch
    # from UDP to TCP when a DNS response is too big to fit in this limited
    # buffer size. This value has also been suggested in DNS Flag Day 2020.
    edns-buffer-size: 1232

    # Perform prefetching of close to expired message cache entries
    # This only applies to domains that have been frequently queried
    prefetch: yes

    # One thread should be sufficient, can be increased on beefy machines. In reality for most users running on small networks or on a single machine, it should be unnecessary to seek performance enhancement by increasing num-threads above 1.
    num-threads: 1

    # Ensure kernel buffer is large enough to not lose messages in traffic spikes
    so-rcvbuf: 1m

    # Ensure privacy of local IP ranges
    private-address: 192.168.0.0/16
    private-address: 169.254.0.0/16
    private-address: 172.16.0.0/12
    private-address: 10.0.0.0/8
    private-address: fd00::/8
    private-address: fe80::/10

```

</details>

Set the root hints file ```/var/lib/unbound/root.hints``` for Unbound

```(shell)
wget -O /var/lib/unbound/root.hints https://www.internic.net/domain/named.root
```

### **Install Pi-Hole**

Make ```/etc/pihole/setupVars.conf``` containing the setup variables for Pi-Hole

```(shell)
WEBPASSWORD="PASSWORD HASH"
PIHOLE_INTERFACE=eth0
IPV4_ADDRESS=192.168.178.101/32
QUERY_LOGGING=true
INSTALL_WEB=true
DNSMASQ_LISTENING=single
PIHOLE_DNS_1=127.0.0.1#5335
PIHOLE_DNS_3=::1#5353
DNS_FQDN_REQUIRED=true
DNS_BOGUS_PRIV=true
DNSSEC=true
TEMPERATUREUNIT=C
WEBUIBOXEDLAYOUT=traditional
API_EXCLUDE_DOMAINS=
API_EXCLUDE_CLIENTS=
API_QUERY_LOG_SHOW=all
API_PRIVACY_MODE=false
```

Install Pi-Hole from url

```(shell)
mkdir /etc/pihole
wget -O ~/pihole-install.sh https://install.pi-hole.net
chmod +x ~/pihole-install.sh

~/pihole-install.sh --unattended
```

Set Pi-Hole admin password

```(shell)
pihole -a -p "ADMIN_PASSWORD"
```

Restart and enable Pi-Hole

```(shell)
pihole enable && pihole restartdns
```

</br>

[Top](#pi-hole-unbound)
