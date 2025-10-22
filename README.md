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

<img width="1076" height="489" alt="image" src="https://github.com/user-attachments/assets/d1c78379-4161-4886-81ca-ec6d25ae3666" />

resolver otomatis

<img width="642" height="124" alt="image" src="https://github.com/user-attachments/assets/7b0e5e78-4670-467a-b132-dc6df43e8b14" />

## Soal 4

Para penjaga nama naik ke menara, di Tirion (ns1/master) bangun zona .com sebagai authoritative dengan SOA yang menunjuk ke ns1..com dan catatan NS untuk ns1..com dan ns2..com. Buat A record untuk ns1..com dan ns2..com yang mengarah ke alamat Tirion dan Valmar sesuai glosarium, serta A record apex .com yang mengarah ke alamat Sirion (front door), aktifkan notify dan allow-transfer ke Valmar, set forwarders ke 192.168.122.1. Di Valmar (ns2/slave) tarik zona .com dari Tirion dan pastikan menjawab authoritative. pada seluruh host non-router ubah urutan resolver menjadi IP dari ns1..com → ns2..com → 192.168.122.1. Verifikasi query ke apex dan hostname layanan dalam zona dijawab melalui ns1/ns2.

### Script

#### Tirion

/etc/bind/named.conf.local 
```
zone "K11.com" {
    type master;
    file "/etc/bind/db.K11.com";
    // Aktifkan notify dan allow-transfer ke Valmar
    allow-transfer { 10.69.3.4; };
    notify yes;
};

```

/etc/bind/named.conf.options

```
options {
    directory "/var/cache/bind";
    
    forwarders {
        192.168.122.1;
    };
    
    allow-query { any; };
    
    allow-recursion { any; };

    auth-nxdomain no;
    listen-on-v6 { none; };
};
```

/etc/bind/db.K11.com

```
$TTL    604800
@       IN      SOA     ns1.K11.com. root.ns1.K11.com. (
                          2025101301 ; Serial (ubah jika ada update)
                            604800     ; Refresh
                             86400     ; Retry
                           2419200     ; Expire
                            604800 )   ; Negative Cache TTL
;
// Catatan NS
@       IN      NS      ns1.K11.com.
@       IN      NS      ns2.K11.com.

; A record untuk ns1 dan ns2
ns1     IN      A       10.69.3.3   // Mengarah ke Tirion
ns2     IN      A       10.69.3.4   // Mengarah ke Valmar

; A record apex (K11.com) mengarah ke Sirion (front door)
@       IN      A       10.69.3.2

; A record layanan lain
sirion  IN      A       10.69.3.2
lindon  IN      A       10.69.3.5
vingilot IN     A       10.69.3.6
```

service bind9 restart


#### Valmar

/etc/bind/named.conf.local

```
zone "K11.com" {
    type slave;
    masters { 10.69.3.3; };   // IP ns1 Tirion
    file "/var/lib/bind/db.K11.com";
};
```

/etc/resolv.conf

```
cat <<EOF > /etc/resolv.conf
search K11.com
nameserver 10.69.3.3
nameserver 10.69.3.4
nameserver 192.168.122.1
EOF
```
service bind9 restart


![WhatsApp Image 2025-10-13 at 22 15 19_b14d04f9](https://github.com/user-attachments/assets/1cbbf2d2-e9b6-4a40-b903-3f0c9285d582)

![WhatsApp Image 2025-10-13 at 22 24 14_be4be2ce](https://github.com/user-attachments/assets/d8730d4b-a34c-4e1b-9004-9046e28aeb4a)

NO 4 BARU

TIRION
<img width="1048" height="245" alt="image" src="https://github.com/user-attachments/assets/d352164c-23b0-4ac8-bf76-e362c07e9027" />

VALMAR

<img width="1123" height="289" alt="image" src="https://github.com/user-attachments/assets/db18131b-3ef8-4de1-9970-085e1c2519d4" />


ping earendil 

<img width="1021" height="247" alt="image" src="https://github.com/user-attachments/assets/4a73a617-a6f3-4037-8bd7-dc5c03f212ba" />



## Soal 5
/etc/bind/db.K11.com


#### Tirion
```
eonwe   IN      A       10.69.1.1
earendil IN     A       10.69.1.2
elwing  IN      A       10.69.1.3
cirdan  IN      A       10.69.2.2
elrond  IN      A       10.69.2.3
maglor  IN      A       10.69.2.4
sirion  IN      A       10.69.3.2
lindon  IN      A       10.69.3.5
vingilot IN     A       10.69.3.6
```

<img width="1053" height="192" alt="image" src="https://github.com/user-attachments/assets/894b570c-55cd-437a-8895-8d91e66f9082" />


![WhatsApp Image 2025-10-20 at 16 58 45_4be9a482](https://github.com/user-attachments/assets/a0417ed7-781f-4a84-bff6-25ceec2a2182)

![WhatsApp Image 2025-10-20 at 16 59 12_3bb08705](https://github.com/user-attachments/assets/a82e7700-7d2d-43f0-bbce-3b2a68c9096d)

![WhatsApp Image 2025-10-20 at 16 59 43_d74507be](https://github.com/user-attachments/assets/7df88df7-d520-4b34-9967-4d45b7ccd43d)


## Soal 6

NO 4 BARU YG DIG LOCAL HOST tirion
<img width="1769" height="691" alt="image" src="https://github.com/user-attachments/assets/78d72f58-94b8-4fe5-b6d8-d71ee4a48c36" />


DIG LOCAL HOST VALMAR

<img width="1804" height="667" alt="image" src="https://github.com/user-attachments/assets/36dd497f-134e-4e0c-942c-421625f59a3d" />

## Soal 7 

CNAME Record
<img width="981" height="676" alt="image" src="https://github.com/user-attachments/assets/40efd6b6-8cdf-442c-bf99-69430f9ef85e" />

