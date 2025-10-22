# Jarkom-Modul-2-2025-K11

## Soal 1

Di tepi Beleriand yang porak-poranda, Eonwe merentangkan tiga jalur: Barat untuk Earendil dan Elwing, Timur untuk Círdan, Elrond, Maglor, serta pelabuhan DMZ bagi Sirion, Tirion, Valmar, Lindon, Vingilot. Tetapkan alamat dan default gateway tiap tokoh sesuai glosarium yang sudah diberikan.

<img width="867" height="807" alt="image" src="https://github.com/user-attachments/assets/70a68147-a087-4cb8-9b34-32e32208db7d" />

### Script

#### Eonwe
```
# WAN (ke NAT)
auto eth0
iface eth0 inet dhcp

# Barat
auto eth1
iface eth1 inet static
    address 10.69.1.1
    netmask 255.255.255.0

# Timur
auto eth2
iface eth2 inet static
    address 10.69.2.1
    netmask 255.255.255.0

# DMZ
auto eth3
iface eth3 inet static
    address 10.69.3.1
    netmask 255.255.255.0

up apt update
up apt install iptables
up iptables -t nat -A POSTROUTING -o eth0 -j MASQUERADE -s 192.234.0.0/16
```
#### Earendil
```
auto eth0
iface eth0 inet static
    address 10.69.1.2
    netmask 255.255.255.0
    gateway 10.69.1.1
up echo nameserver 192.168.122.1 > /etc/resolv.conf
```

#### Elwing 
```
auto eth0
iface eth0 inet static
    address 10.69.1.3
    netmask 255.255.255.0
    gateway 10.69.1.1
up echo nameserver 192.168.122.1 > /etc/resolv.conf
```

#### Cirdan
```
auto eth0
iface eth0 inet static
    address 10.69.2.2
    netmask 255.255.255.0
    gateway 10.69.2.1
up echo nameserver 192.168.122.1 > /etc/resolv.conf
```

#### Elrond
```
auto eth0
iface eth0 inet static
    address 10.69.2.3
    netmask 255.255.255.0
    gateway 10.69.2.1
up echo nameserver 192.168.122.1 > /etc/resolv.conf
```

#### Maglor
```
auto eth0
iface eth0 inet static
    address 10.69.2.4
    netmask 255.255.255.0
    gateway 10.69.2.1
up echo nameserver 192.168.122.1 > /etc/resolv.conf
```

#### Sirion
```
auto eth0
iface eth0 inet static
    address 10.69.3.2
    netmask 255.255.255.0
    gateway 10.69.3.1
up echo nameserver 192.168.122.1 > /etc/resolv.conf
```

#### Tirion
```
auto eth0
iface eth0 inet static
    address 10.69.3.3
    netmask 255.255.255.0
    gateway 10.69.3.1
up echo nameserver 192.168.122.1 > /etc/resolv.conf
```

#### Valmar
```
auto eth0
iface eth0 inet static
    address 10.69.3.4
    netmask 255.255.255.0
    gateway 10.69.3.1
up echo nameserver 192.168.122.1 > /etc/resolv.conf
```

#### Lindon
```
auto eth0
iface eth0 inet static
    address 10.69.3.5
    netmask 255.255.255.0
    gateway 10.69.3.1
up echo nameserver 192.168.122.1 > /etc/resolv.conf
```

#### Vingilot
```
auto eth0
iface eth0 inet static
    address 10.69.3.6
    netmask 255.255.255.0
    gateway 10.69.3.1
up echo nameserver 192.168.122.1 > /etc/resolv.conf
```

