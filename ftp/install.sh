apt-get update
apt-get install proftpd -y << EOF
2
EOF

cat > /etc/proftpd/conf.d/custom.conf << EOF
   RequireValidShell  off
   AuthUserFile  /etc/proftpd/ftpd.passwd
   DefaultRoot ~
EOF

mkdir /var/ftp
