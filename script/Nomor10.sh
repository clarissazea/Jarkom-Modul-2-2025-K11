#!/bin/bash
# Vingilot - Setup Dynamic Web Server (PHP)

echo "=== Setting up Dynamic Web Server at Vingilot ==="

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

# Konfigurasi Nginx
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

