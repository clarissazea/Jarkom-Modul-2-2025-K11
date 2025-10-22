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
## Soal 2

<img width="1382" height="820" alt="image" src="https://github.com/user-attachments/assets/56e1ee84-47c8-4b3c-bef7-98966e44942c" />

## Soal 3

ping lindon ke sirion

<img width="1005" height="440" alt="image" src="https://github.com/user-attachments/assets/c3df4254-6514-495c-b83d-6ac3ce4733d1" />

ping elwing ke elrond (barat ke timur)

<img width="1015" height="560" alt="image" src="https://github.com/user-attachments/assets/af966840-8420-4fdf-bee7-3ac939cd1622" />

ping maglor ke earendil (timur ke barat)

resolver otomatis
<img width="642" height="124" alt="image" src="https://github.com/user-attachments/assets/7b0e5e78-4670-467a-b132-dc6df43e8b14" />


