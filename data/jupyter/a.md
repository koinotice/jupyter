$ pip3 install runipy # for python 3.x 
$ pip install runipy  # for python 2.x





COPY crontab /etc/cron.d/backup-cron
RUN chmod 0644 /etc/cron.d/backup-cron && \
  touch /var/log/syslog

COPY scripts /scripts
RUN touch /var/log/cron-stdout.log

CMD env > /root/env && sed -i '/GPG_KEYS/d' /root/env && sed -i '/no_proxy/d' /root/env && sed -i -e 's/^/export /' /root/env && chmod +x /root/env && rsyslogd && cron && tail -F /var/log/syslog /var/log/cron-stdout.log


#* * * * * root /bin/sh /scripts/hello-world.sh >> /var/log/cron-stdout.log 2>&1
00 01 * * * root /bin/sh /scripts/mongodb-to-s3.sh >> /var/log/cron-stdout.log 2>&1
00 00 * * * root /bin/sh /scripts/postgres-to-s3.sh >> /var/log/cron-stdout.log 2>&1
00 00 * * * root /bin/sh /scripts/mariadb-to-s3.sh >> /var/log/cron-stdout.log 2>&1
30 00 * * * root /bin/sh /scripts/scp-to-s3.sh >> /var/log/cron-stdout.log 2>&1


import pandas as pd
import mysql.connector
from sqlalchemy import create_engine

myd = pd.read_csv('/[path]/[filename].csv')

engine = create_engine('mysql+mysqlconnector://[user]:[pw]@127.0.0.1/[dbname]')

myd.to_sql(name='[tablename]', con=engine, if_exists='replace', index=False)