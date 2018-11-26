FROM continuumio/anaconda3

WORKDIR /data/jupyter

COPY docker-entrypoint.sh /data/scripts/
COPY requirements.txt /data/scripts/
RUN chmod +x /data/scripts/docker-entrypoint.sh

EXPOSE 8888



ENTRYPOINT [ "/usr/bin/tini", "--" ]
CMD [ "/data/scripts/docker-entrypoint.sh" ]

