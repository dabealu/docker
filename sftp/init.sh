#!/bin/bash -e

id ${SFTP_USER:-sftp}; err=$?

# create or modify sftp user
if [[ "${err}" == "0" ]]; then
  usermod -U \
    --home ${SFTP_HOME:-/home/sftp} \
    --uid ${SFTP_UID:-1000} \
    --gid ${SFTP_GID:-1000} \
    -s /usr/bin/mysecureshell \
    ${SFTP_USER:-sftp}
else
  useradd -m \
    --uid ${SFTP_UID:-1000} \
    --gid ${SFTP_GID:-1000} \
    --home-dir ${SFTP_HOME:-/home/sftp} \
    -s /usr/bin/mysecureshell \
    ${SFTP_USER:-sftp} || true
fi

# set sftp user's password
cat <<EOF > /root/ftpasswd
${SFTP_USER:-sftp}:${SFTP_PASSWORD:-sftp}
EOF
chpasswd < /root/ftpasswd

# start and periodically check that sshd alive
service ssh start

while true; do
  if [[ -n "$(ps -axo cmd | grep '/usr/sbin/sshd')" ]]; then
    sleep 5
  else
    echo "ERROR: openssh-server exited"
    exit 1
  fi
done

