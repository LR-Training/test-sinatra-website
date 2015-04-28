#!/bin/bash
set -e

gem install sinatra
gem install pg
gem install rerun


sudo -u postgres psql -p 5432  << "EOF"
CREATE DATABASE test;

EOF
sudo -u postgres psql -p 5432 test << "EOF"
  CREATE DATABASE test;

  CREATE TABLE users (
    user_id  SERIAL PRIMARY KEY,
    user_name    varchar(40),
    user_password    varchar(40),
    user_status    integer
  );

EOF

cat <<EOF >> /etc/rc.local
  nohup ruby /home/vagrant/test-sinatra-website/run.rb >> log.txt 2>&1 &

EOF

nohup ruby /home/vagrant/test-sinatra-website/run.rb >> log.txt 2>&1 &
