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
Angin dari luar mulai berhembus ketika Eonwe membuka jalan ke awan NAT. Pastikan jalur WAN di router aktif dan NAT meneruskan trafik keluar bagi seluruh alamat internal sehingga host di dalam dapat mencapai layanan di luar menggunakan IP address.

`ping google.com` untuk `Lindon`.

<img width="1382" height="820" alt="image" src="https://github.com/user-attachments/assets/56e1ee84-47c8-4b3c-bef7-98966e44942c" />

## Soal 3

Kabar dari Barat menyapa Timur. Pastikan kelima klien dapat saling berkomunikasi lintas jalur (routing internal via Eonwe berfungsi), lalu pastikan setiap host non-router menambahkan resolver 192.168.122.1 saat interfacenya aktif agar akses paket dari internet tersedia sejak awal.

ping `Lindon ke Sirion`

<img width="1005" height="440" alt="image" src="https://github.com/user-attachments/assets/c3df4254-6514-495c-b83d-6ac3ce4733d1" />

ping `Elwing ke Elrond (barat ke timur)`

<img width="1015" height="560" alt="image" src="https://github.com/user-attachments/assets/af966840-8420-4fdf-bee7-3ac939cd1622" />

ping `Maglor ke Earendil (timur ke barat)`

<img width="1076" height="489" alt="image" src="https://github.com/user-attachments/assets/d1c78379-4161-4886-81ca-ec6d25ae3666" />

`resolver otomatis`

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

#### Pengujian

Tirion

<img width="1048" height="245" alt="image" src="https://github.com/user-attachments/assets/d352164c-23b0-4ac8-bf76-e362c07e9027" />

Valmar

<img width="1123" height="289" alt="image" src="https://github.com/user-attachments/assets/db18131b-3ef8-4de1-9970-085e1c2519d4" />


ping earendil 

<img width="1021" height="247" alt="image" src="https://github.com/user-attachments/assets/4a73a617-a6f3-4037-8bd7-dc5c03f212ba" />



## Soal 5
“Nama memberi arah,” kata Eonwe. Namai semua tokoh (hostname) sesuai glosarium, eonwe, earendil, elwing, cirdan, elrond, maglor, sirion, tirion, valmar, lindon, vingilot, dan verifikasi bahwa setiap host mengenali dan menggunakan hostname tersebut secara system-wide. Buat setiap domain untuk masing masing node sesuai dengan namanya (contoh: eru.<xxxx>.com) dan assign IP masing-masing juga. Lakukan pengecualian untuk node yang bertanggung jawab atas ns1 dan ns2

### Script Update

```
no5baru

#!/bin/bash

# Backup file zona lama
cp /etc/bind/db.K11.com /etc/bind/db.K11.com.backup

# Update file zona dengan semua node
cat > /etc/bind/db.K11.com << 'EOF'
;
; BIND data file for K11.com
;
$TTL    604800
@       IN      SOA     ns1.K11.com. admin.K11.com. (
                          2025101302    ; Serial (INCREMENT!)
                            604800      ; Refresh
                             86400      ; Retry
                           2419200      ; Expire
                            604800 )    ; Negative Cache TTL
;
; Catatan NS
@       IN      NS      ns1.K11.com.
@       IN      NS      ns2.K11.com.

; A record untuk ns1 dan ns2
ns1     IN      A       10.69.3.3
ns2     IN      A       10.69.3.4

; A record apex (K11.com) mengarah ke Sirion (front door)
@       IN      A       10.69.3.2

; A record untuk semua node (kecuali ns1/ns2)
eonwe    IN      A       10.69.3.1
earendil IN      A       10.69.1.2
elwing   IN      A       10.69.1.3
cirdan   IN      A       10.69.2.2
elrond   IN      A       10.69.2.3
maglor   IN      A       10.69.2.4
sirion   IN      A       10.69.3.2
lindon   IN      A       10.69.3.5
vingilot IN      A       10.69.3.6

; CNAME records untuk alias
www      IN      CNAME   sirion.K11.com.
static   IN      CNAME   lindon.K11.com.
app      IN      CNAME   vingilot.K11.com.
EOF

# Set permission
chmod 644 /etc/bind/db.K11.com
chown bind:bind /etc/bind/db.K11.com

# Check zona
named-checkzone K11.com /etc/bind/db.K11.com

# Restart BIND9
service bind9 restart

echo "Zona updated. Testing..."
sleep 2

# Test
dig @localhost K11.com SOA +short
dig @localhost earendil.K11.com +short
dig @localhost cirdan.K11.com +short
dig @localhost www.K11.com +short
dig @localhost static.K11.com +short
dig @localhost app.K11.com +short

echo "Done! Check serial number: should be 2025101302"
```

#### Tirion

<img width="1053" height="192" alt="image" src="https://github.com/user-attachments/assets/894b570c-55cd-437a-8895-8d91e66f9082" />

Tidak bisa karena Tirion adalah ns1

![WhatsApp Image 2025-10-20 at 16 59 12_3bb08705](https://github.com/user-attachments/assets/a82e7700-7d2d-43f0-bbce-3b2a68c9096d)

#### Eonwe

![WhatsApp Image 2025-10-20 at 16 59 43_d74507be](https://github.com/user-attachments/assets/7df88df7-d520-4b34-9967-4d45b7ccd43d)


## Soal 6

Lonceng Valmar berdentang mengikuti irama Tirion. Pastikan zone transfer berjalan, Pastikan Valmar (ns2) telah menerima salinan zona terbaru dari Tirion (ns1). Nilai serial SOA di keduanya harus sama

Cek Nomor Serial di Master (Tirion) dengan `dig @localhost K11.com SOA`

<img width="1769" height="691" alt="image" src="https://github.com/user-attachments/assets/78d72f58-94b8-4fe5-b6d8-d71ee4a48c36" />


Cek Nomor Serial di Slave (Valmar) dengan `dig @localhost K11.com SOA`

<img width="1804" height="667" alt="image" src="https://github.com/user-attachments/assets/36dd497f-134e-4e0c-942c-421625f59a3d" />

Jika nomor serial di Valmar sama dengan di Tirion, hal ini membuktikan bahwa proses zone transfer telah berhasil. Hasil pengujian menunjukkan kedua nomor (master dan slave) serial identik, sehingga terjadi sinkronisasi.

## Soal 7 

Peta kota dan pelabuhan dilukis. Sirion sebagai gerbang, Lindon sebagai web statis, Vingilot sebagai web dinamis. Tambahkan pada zona .com A record untuk sirion..com (IP Sirion), lindon..com (IP Lindon), dan vingilot..com (IP Vingilot). Tetapkan CNAME :

www.<xxxx>.com → sirion.<xxxx>.com,
static.<xxxx>.com → lindon.<xxxx>.com, dan
app.<xxxx>.com → vingilot.<xxxx>.com. Verifikasi dari dua klien berbeda bahwa seluruh hostname tersebut ter-resolve ke tujuan yang benar dan konsisten.

##### CNAME Record (sudah diupdate di nomor 5 dan 6)
<img width="981" height="676" alt="image" src="https://github.com/user-attachments/assets/40efd6b6-8cdf-442c-bf99-69430f9ef85e" />

##### Pengujian di client (Cirdan)

<img width="930" height="423" alt="image" src="https://github.com/user-attachments/assets/b0ed4ed3-6fd8-43fe-8077-bc8602fe3893" />

```
dig www.K11.com +short
dig static.K11.com +short
dig app.K11.com +short
```

<img width="672" height="273" alt="image" src="https://github.com/user-attachments/assets/665b3fd2-9943-44e6-b124-999ac51cc506" />

## Soal 8

Setiap jejak harus bisa diikuti. Di Tirion (ns1) deklarasikan satu reverse zone untuk segmen DMZ tempat Sirion, Lindon, Vingilot berada. Di Valmar (ns2) tarik reverse zone tersebut sebagai slave, isi PTR untuk ketiga hostname itu agar pencarian balik IP address mengembalikan hostname yang benar, lalu pastikan query reverse untuk alamat Sirion, Lindon, Vingilot dijawab authoritative.

#### Script

#### Tirion
```
#Creating reverse zone file..."
mkdir -p /etc/bind/zones

cat > /etc/bind/zones/db.3.69.10.in-addr.arpa <<'EOF'
$TTL 604800
@   IN  SOA ns1.K11.com. admin.K11.com. (
        2025101301 ; Serial
        604800     ; Refresh
        86400      ; Retry
        2419200    ; Expire
        604800 )   ; Negative Cache TTL

; === Authoritative Nameservers ===
    IN  NS  ns1.K11.com.
    IN  NS  ns2.K11.com.

; === PTR RECORDS (DMZ Segment 10.69.3.0/24) ===
1   IN  PTR eonwe.K11.com.
2   IN  PTR sirion.K11.com.
3   IN  PTR ns1.K11.com.
4   IN  PTR ns2.K11.com.
5   IN  PTR lindon.K11.com.
6   IN  PTR vingilot.K11.com.
EOF

#Cleaning old reverse zone configuration..."
sed -i '/^zone "3\.69\.10\.in-addr\.arpa"/,/^}/d' /etc/bind/named.conf.local

#Adding reverse zone configuration..."
cat >> /etc/bind/named.conf.local <<'EOF'

zone "3.69.10.in-addr.arpa" {
    type master;
    file "/etc/bind/zones/db.3.69.10.in-addr.arpa";
    allow-transfer { 10.69.3.4; };  // Valmar (slave)
    also-notify { 10.69.3.4; };
    notify yes;
};
EOF

#Verifying configuration..."
named-checkconf
named-checkzone 3.69.10.in-addr.arpa /etc/bind/zones/db.3.69.10.in-addr.arpa

#Restarting BIND9..."
service bind9 restart



```

#### Valmar
```

# Cleaning old reverse zone configuration..."
sed -i '/^zone "3\.69\.10\.in-addr\.arpa"/,/^}/d' /etc/bind/named.conf.local
echo "✅ Old config removed (if exists)"

#Adding reverse zone slave configuration..."
cat >> /etc/bind/named.conf.local <<'EOF'

zone "3.69.10.in-addr.arpa" {
    type slave;
    file "/var/cache/bind/db.3.69.10.in-addr.arpa";
    masters { 10.69.3.3; };  // Tirion (master)
};
EOF

service bind9 restart

```

`namecheck`

<img width="1169" height="121" alt="image" src="https://github.com/user-attachments/assets/307ba280-534b-40c8-83ff-f591b9b6d7a5" />

#### Tirion

`dig -x 10.69.3.2`

<img width="1182" height="642" alt="image" src="https://github.com/user-attachments/assets/db35596c-db52-42a7-9ebd-710b1617f2fb" />

`dig -x 10.69.3.3`

<img width="1129" height="662" alt="image" src="https://github.com/user-attachments/assets/592b957f-11a5-4b5e-a899-e0e5f1c17f4c" />


`dig -x 10.69.3.4`

<img width="1137" height="659" alt="image" src="https://github.com/user-attachments/assets/96f8d3e0-9ea8-4474-8e35-2a5d471362ae" />

#### Valmar

`dig -x 10.69.3.2`
<img width="1121" height="653" alt="image" src="https://github.com/user-attachments/assets/ca291a77-5bf7-4663-9212-aebbf1331eb6" />



`dig -x 10.69.3.3`
<img width="1133" height="664" alt="image" src="https://github.com/user-attachments/assets/0495382f-2bb8-4f4a-8fcb-970b94880a0d" />



`dig -x 10.69.3.4`
<img width="1137" height="669" alt="image" src="https://github.com/user-attachments/assets/c2136f3c-97e2-43d6-b0a8-79c6d4034012" />

## Soal 9 

Lampion Lindon dinyalakan. Jalankan web statis pada hostname static..com dan buka folder arsip /annals/ dengan autoindex (directory listing) sehingga isinya dapat ditelusuri. Akses harus dilakukan melalui hostname, bukan IP.

### Script

```
# Install Nginx
apt-get update
apt-get install nginx -y

# Buat direktori
mkdir -p /var/www/static.K11.com/annals
mkdir -p /var/www/static.K11.com/annals/archives
mkdir -p /var/www/static.K11.com/annals/documents

# Buat file contoh di /annals/
cat > /var/www/static.K11.com/annals/README.txt << 'EOF'
=== Lindon Archive System ===
This directory contains historical records and documents.

Access via: http://static.K11.com/annals/
EOF

cat > /var/www/static.K11.com/annals/doc1.html << 'EOF'
<!DOCTYPE html>
<html>
<head><title>Document 1</title></head>
<body>
    <h1>Historical Document 1</h1>
    <p>This is the first archived document from the Lindon archives.</p>
    <p>Date: 2025-10-23</p>
</body>
</html>
EOF

cat > /var/www/static.K11.com/annals/doc2.html << 'EOF'
<!DOCTYPE html>
<html>
<head><title>Document 2</title></head>
<body>
    <h1>Historical Document 2</h1>
    <p>This is the second archived document from the Lindon archives.</p>
    <p>Date: 2025-10-23</p>
</body>
</html>
EOF

echo "Archive file 1 - Confidential records" > /var/www/static.K11.com/annals/archives/archive1.txt
echo "Archive file 2 - Historical maps" > /var/www/static.K11.com/annals/archives/archive2.txt
echo "Document A - Treaty of Beleriand" > /var/www/static.K11.com/annals/documents/document-a.txt
echo "Document B - Chronicles" > /var/www/static.K11.com/annals/documents/document-b.txt

# Buat halaman utama
cat > /var/www/static.K11.com/index.html << 'EOF'
<!DOCTYPE html>
<html>
<head>
    <title>Lindon - Static Archive Server</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            max-width: 800px;
            margin: 50px auto;
            padding: 20px;
            background: #f4f4f4;
        }
        .container {
            background: white;
            padding: 30px;
            border-radius: 8px;
            box-shadow: 0 2px 4px rgba(0,0,0,0.1);
        }
        h1 { color: #2c3e50; }
        a {
            color: #3498db;
            text-decoration: none;
            font-weight: bold;
        }
        a:hover { text-decoration: underline; }
    </style>
</head>
<body>
    <div class="container">
        <h1>🏛️ Welcome to Lindon Archive</h1>
        <p>This is the static file server hosting historical archives of K11 realm.</p>
        <h2>Available Resources:</h2>
        <ul>
            <li><a href="/annals/">Browse Annals Directory (with autoindex)</a></li>
            <li><a href="/annals/doc1.html">Document 1</a></li>
            <li><a href="/annals/doc2.html">Document 2</a></li>
        </ul>
        <hr>
        <p><small>Powered by Nginx | Hostname: static.K11.com</small></p>
    </div>
</body>
</html>
EOF

# Konfigurasi Nginx
cat > /etc/nginx/sites-available/static.K11.com << 'EOF'
server {
    listen 80;
    server_name static.K11.com;

    root /var/www/static.K11.com;
    index index.html;

    # Access log
    access_log /var/log/nginx/static.K11.com.access.log;
    error_log /var/log/nginx/static.K11.com.error.log;

    # Default location
    location / {
        try_files $uri $uri/ =404;
    }

    # Autoindex untuk /annals/
    location /annals/ {
        autoindex on;
        autoindex_exact_size off;
        autoindex_localtime on;
    }
}
EOF

# Enable site
ln -sf /etc/nginx/sites-available/static.K11.com /etc/nginx/sites-enabled/
rm -f /etc/nginx/sites-enabled/default

# Test konfigurasi
nginx -t

# Restart Nginx
service nginx restart

```

`start nginx`
<img width="1121" height="146" alt="image" src="https://github.com/user-attachments/assets/6e4eb74e-6120-4682-9894-376f622ea457" />


`curl http://static.K11.com`
<img width="1017" height="943" alt="image" src="https://github.com/user-attachments/assets/bee8b9bd-ffd8-4798-9978-9a5cf7526018" />


## Soal 10

Vingilot mengisahkan cerita dinamis. Jalankan web dinamis (PHP-FPM) pada hostname app..com dengan beranda dan halaman about, serta terapkan rewrite sehingga /about berfungsi tanpa akhiran .php. Akses harus dilakukan melalui hostname.

### Script

```
# Install Nginx dan PHP
apt-get update
apt-get install nginx php8.4-fpm php8.4-cli -y

# Buat direktori
mkdir -p /var/www/app.K11.com

# Buat index.php (Homepage)
cat > /var/www/app.K11.com/index.php << 'EOF'
<!DOCTYPE html>
<html>
<head>
    <title>Vingilot - Dynamic Application</title>
    <style>
        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            max-width: 900px;
            margin: 50px auto;
            padding: 20px;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
        }
        .container {
            background: rgba(255, 255, 255, 0.95);
            padding: 40px;
            border-radius: 15px;
            box-shadow: 0 10px 30px rgba(0,0,0,0.3);
            color: #333;
        }
        h1 {
            color: #667eea;
            border-bottom: 3px solid #764ba2;
            padding-bottom: 10px;
        }
        .info-box {
            background: #f8f9fa;
            padding: 20px;
            margin: 20px 0;
            border-left: 4px solid #667eea;
            border-radius: 5px;
        }
        .info-box h3 {
            margin-top: 0;
            color: #764ba2;
        }
        a {
            display: inline-block;
            background: #667eea;
            color: white;
            padding: 12px 30px;
            text-decoration: none;
            border-radius: 5px;
            margin-top: 20px;
            transition: background 0.3s;
        }
        a:hover {
            background: #764ba2;
        }
        .stats {
            display: grid;
            grid-template-columns: repeat(2, 1fr);
            gap: 15px;
            margin: 20px 0;
        }
        .stat-item {
            background: #e9ecef;
            padding: 15px;
            border-radius: 8px;
            text-align: center;
        }
        .stat-value {
            font-size: 24px;
            font-weight: bold;
            color: #667eea;
        }
    </style>
</head>
<body>
    <div class="container">
        <h1>🚀 Welcome to Vingilot</h1>
        <p>This is a dynamic PHP application serving the K11 realm.</p>
        
        <div class="info-box">
            <h3>📊 Server Information</h3>
            <div class="stats">
                <div class="stat-item">
                    <div class="stat-value"><?php echo date('H:i:s'); ?></div>
                    <div>Current Time</div>
                </div>
                <div class="stat-item">
                    <div class="stat-value"><?php echo date('Y-m-d'); ?></div>
                    <div>Today's Date</div>
                </div>
                <div class="stat-item">
                    <div class="stat-value"><?php echo $_SERVER['SERVER_NAME']; ?></div>
                    <div>Hostname</div>
                </div>
                <div class="stat-item">
                    <div class="stat-value"><?php echo $_SERVER['REMOTE_ADDR']; ?></div>
                    <div>Your IP</div>
                </div>
            </div>
        </div>

        <div class="info-box">
            <h3>⚙️ Technical Details</h3>
            <p><strong>PHP Version:</strong> <?php echo phpversion(); ?></p>
            <p><strong>Server Software:</strong> <?php echo $_SERVER['SERVER_SOFTWARE']; ?></p>
            <p><strong>Document Root:</strong> <?php echo $_SERVER['DOCUMENT_ROOT']; ?></p>
            <p><strong>Request Method:</strong> <?php echo $_SERVER['REQUEST_METHOD']; ?></p>
        </div>

        <a href="/about">Learn More About Vingilot →</a>
    </div>
</body>
</html>
EOF

# Buat about.php
cat > /var/www/app.K11.com/about.php << 'EOF'
<!DOCTYPE html>
<html>
<head>
    <title>Vingilot - About</title>
    <style>
        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            max-width: 900px;
            margin: 50px auto;
            padding: 20px;
            background: linear-gradient(135deg, #f093fb 0%, #f5576c 100%);
            color: white;
        }
        .container {
            background: rgba(255, 255, 255, 0.95);
            padding: 40px;
            border-radius: 15px;
            box-shadow: 0 10px 30px rgba(0,0,0,0.3);
            color: #333;
        }
        h1 {
            color: #f5576c;
            border-bottom: 3px solid #f093fb;
            padding-bottom: 10px;
        }
        .content-section {
            background: #f8f9fa;
            padding: 25px;
            margin: 20px 0;
            border-radius: 8px;
            border-left: 5px solid #f5576c;
        }
        .feature-list {
            list-style: none;
            padding: 0;
        }
        .feature-list li {
            padding: 10px 0;
            border-bottom: 1px solid #dee2e6;
        }
        .feature-list li:before {
            content: "✓ ";
            color: #f5576c;
            font-weight: bold;
            margin-right: 10px;
        }
        a {
            display: inline-block;
            background: #f5576c;
            color: white;
            padding: 12px 30px;
            text-decoration: none;
            border-radius: 5px;
            margin-top: 20px;
            transition: background 0.3s;
        }
        a:hover {
            background: #f093fb;
        }
        .php-info {
            background: #e3f2fd;
            padding: 15px;
            border-radius: 5px;
            margin: 15px 0;
        }
    </style>
</head>
<body>
    <div class="container">
        <h1>📖 About Vingilot</h1>
        
        <div class="content-section">
            <h2>Mission</h2>
            <p>Vingilot serves as the dynamic web application platform for the K11 domain, providing interactive and data-driven services to all realms within the network.</p>
        </div>

        <div class="content-section">
            <h2>🌟 Features</h2>
            <ul class="feature-list">
                <li>Dynamic PHP-powered applications</li>
                <li>Real-time data processing</li>
                <li>Clean URL rewriting (/about without .php)</li>
                <li>High-performance Nginx + PHP-FPM stack</li>
                <li>Seamless integration with K11 DNS infrastructure</li>
            </ul>
        </div>

        <div class="content-section">
            <h2>💻 System Information</h2>
            <div class="php-info">
                <p><strong>Server Hostname:</strong> <?php echo gethostname(); ?></p>
                <p><strong>PHP Version:</strong> <?php echo phpversion(); ?></p>
                <p><strong>Loaded Extensions:</strong> <?php echo count(get_loaded_extensions()); ?> modules</p>
                <p><strong>Server IP:</strong> <?php echo $_SERVER['SERVER_ADDR']; ?></p>
                <p><strong>Request URI:</strong> <?php echo $_SERVER['REQUEST_URI']; ?></p>
                <p><strong>Script Name:</strong> <?php echo $_SERVER['SCRIPT_NAME']; ?></p>
            </div>
        </div>

        <div class="content-section">
            <h2>🔧 Technical Stack</h2>
            <p><strong>Web Server:</strong> Nginx</p>
            <p><strong>Application Layer:</strong> PHP <?php echo phpversion(); ?> with FPM</p>
            <p><strong>DNS:</strong> Integrated with ns1.K11.com and ns2.K11.com</p>
            <p><strong>Domain:</strong> app.K11.com (CNAME → vingilot.K11.com)</p>
        </div>

        <a href="/">← Back to Home</a>
    </div>
</body>
</html>
EOF

# Set permission
chown -R www-data:www-data /var/www/app.K11.com
chmod -R 755 /var/www/app.K11.com
```

`Konfigurasi Nginx`

```

cat > /etc/nginx/sites-available/app.K11.com << 'EOF'
server {
    listen 80;
    server_name app.K11.com;

    root /var/www/app.K11.com;
    index index.php index.html;

    # Access log
    access_log /var/log/nginx/app.K11.com.access.log;
    error_log /var/log/nginx/app.K11.com.error.log;

    # Default location
    location / {
        try_files $uri $uri/ /index.php?$query_string;
    }

    # PHP-FPM configuration
    location ~ \.php$ {
        include snippets/fastcgi-php.conf;
        fastcgi_pass unix:/var/run/php/php8.4-fpm.sock;
        fastcgi_param SCRIPT_FILENAME $document_root$fastcgi_script_name;
        include fastcgi_params;
    }

    # Rewrite /about → /about.php (tanpa akhiran .php)
    rewrite ^/about$ /about.php last;

    # Deny access to hidden files
    location ~ /\. {
        deny all;
    }
}
EOF

# Enable site
ln -sf /etc/nginx/sites-available/app.K11.com /etc/nginx/sites-enabled/
rm -f /etc/nginx/sites-enabled/default

# Test konfigurasi
nginx -t

# Restart services
service php8.4-fpm restart
service nginx restart
```

<img width="1080" height="271" alt="image" src="https://github.com/user-attachments/assets/70dadc3f-5a24-4c18-a7d7-8a113927c9e8" />

<img width="900" height="135" alt="image" src="https://github.com/user-attachments/assets/5eaf57d3-6d19-4949-8179-4920ae75a4e5" />


`Run`

<img width="1233" height="1046" alt="image" src="https://github.com/user-attachments/assets/588f1f91-42f3-448d-b981-3ec58941cf9f" />

<img width="1335" height="1082" alt="image" src="https://github.com/user-attachments/assets/1c7ab2c6-7f79-4334-bf6a-fd01b09c527f" />


`Curl`

<img width="896" height="199" alt="image" src="https://github.com/user-attachments/assets/4c032d33-8849-4652-b283-9a3fb2220fb4" />

