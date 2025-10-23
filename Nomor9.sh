#!/bin/bash
# Lindon - Setup Static Web Server

echo "=== Setting up Static Web Server at Lindon ==="

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

