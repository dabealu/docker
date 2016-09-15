#docker run -d -h vault --name vault -v $PWD/vault_data:/vault -v $PWD/vault.hcl:/vault.hcl -p 8200:8200 -e VAULT_ADDR=http://127.0.0.1:8200 vault:0.5.3

FROM  debian:8

ENV   VAULT_V=0.5.3

RUN   apt-get update -qq &&\
      apt-get install unzip wget -yqq &&\
      wget -q https://releases.hashicorp.com/vault/${VAULT_V}/vault_${VAULT_V}_linux_amd64.zip &&\
      unzip vault_${VAULT_V}_linux_amd64.zip &&\
      rm -f vault_${VAULT_V}_linux_amd64.zip &&\
      mv vault /usr/bin/

COPY  vault.hcl /vault.hcl

EXPOSE  8200

CMD   ["/usr/bin/vault", "server", "-config=/vault.hcl"]
