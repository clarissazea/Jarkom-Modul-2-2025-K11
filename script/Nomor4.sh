# Tirion
apt update
apt install bind9 -y               

mkdir -p /etc/bind/zones

nano /etc/bind/named.conf.local        

zone "K11.com" {
    type master;
    file "/etc/bind/db.K11.com";
    // Aktifkan notify dan allow-transfer ke Valmar
    allow-transfer { 10.69.3.4; };
    notify yes;
};

nano /etc/bind/named.conf.options

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

nano /etc/bind/db.K11.com

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

#Valmar

nano /etc/bind/named.conf.local

zone "K11.com" {
    type slave;
    masters { 10.69.3.3; };   // IP ns1 Tirion
    file "/var/lib/bind/db.K11.com";
};


ln -s /etc/init.d/named /etc/init.d/bind9

servive bind9 restart


nano /etc/resolv.conf

cat <<EOF > /etc/resolv.conf
search K11.com
nameserver 10.69.3.3
nameserver 10.69.3.4
nameserver 192.168.122.1
EOF

service bind9 restart

ping K11.com
