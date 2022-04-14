INSTANCEPUBLICIP=$(curl ipinfo.io/ip)

sudo cat << EOF >> nginx.conf
upstream snowapp {
    server ${INSTANCEPUBLICIP}:16000;

    keepalive 8;
}

server {
        listen 80;
        listen 443 ssl;

        server_name     now.timabiok.com;
        ssl_certificate     /etc/ssl/certs/now.timabiok.com.crt;
        ssl_certificate_key /etc/ssl/private/now.timabiok.com.key;

        location / {
        proxy_pass http://snowapp;
    }
}
EOF
