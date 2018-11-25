FROM ubuntu:latest

COPY ./source.list /etc/apt/sources.list

# Install cron
RUN apt-get update && apt-get -y install cron

# Create the log file to be able to run tail
RUN touch /var/log/cron.log

# Setup cron job
RUN (crontab -l ; echo "* * * * * echo "Hello world" >> /var/log/cron.log") | crontab

CMD [ "/bin/bash" ]

ENTRYPOINT ["cron start"]

#ENTRYPOINT [ "/usr/sbin/crond", "-f", "-c", "/etc/cron.d" ]
