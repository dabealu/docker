Web-UI password created at image build (username backuppc):
docker build --build-arg WEB_PASSWD=<PASSWORD> -t webgears/backuppc .
Change password:
htpasswd /etc/backuppc/htpasswd backuppc

Create or copy private key file to allow backuppc ssh access:
mkdir /var/lib/backuppc/.ssh
cp private_key_file /var/lib/backuppc/.ssh/id_rsa
chmod 700 /var/lib/backuppc/.ssh
chmod 600 /var/lib/backuppc/.ssh/id_rsa
chown -R backuppc:backuppc /var/lib/backuppc/.ssh
