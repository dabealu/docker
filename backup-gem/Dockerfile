FROM ruby:2.2.7

RUN  echo 'deb http://apt.postgresql.org/pub/repos/apt/ jessie-pgdg main' >/etc/apt/sources.list.d/pgdg.list &&\
     wget --quiet -O - https://www.postgresql.org/media/keys/ACCC4CF8.asc | apt-key add - &&\
     apt-get update &&\
     apt-get install -y postgresql-9.6

RUN  apt-get install -y --no-install-recommends cron &&\
     rm -rf /var/lib/apt/lists/*

RUN  gem install backup -v '4.3.0' &&\
     backup generate:config

CMD  ["/usr/sbin/cron", "-f"]

