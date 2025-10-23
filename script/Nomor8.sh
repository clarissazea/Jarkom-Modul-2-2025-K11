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



## VALMARR

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



echo "Testing PTR records:"
echo "1. Sirion (10.69.3.2):"
dig @localhost -x 10.69.3.2 +short

echo "2. Tirion/ns1 (10.69.3.3):"
dig @localhost -x 10.69.3.3 +short

echo "3. Valmar/ns2 (10.69.3.4):"
dig @localhost -x 10.69.3.4 +short

echo "4. Lindon (10.69.3.5):"
dig @localhost -x 10.69.3.5 +short

echo "5. Vingilot (10.69.3.6):"
dig @localhost -x 10.69.3.6 +short
