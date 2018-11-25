#FROM jupyter/datascience-notebook:latest as Base
#USER root
#
#RUN apt-get update && apt-get -yq dist-upgrade \
#    && apt-get install -yq --no-install-recommends \
#    vim \
#    cron \
#    && apt-get clean \
#     && rm -rf /var/lib/apt/lists/*
#
#ADD ./jupyter_notebook_config.py /home/jovyan/.jupyter/
#
#FROM koinotice/jupyter:e214e2a
#USER root
#RUN echo "root:root" | chpasswd

FROM  phusion/baseimage:master

ENV LANG=C.UTF-8 LC_ALL=C.UTF-8
ENV PATH /opt/conda/bin:$PATH

#COPY ./data/source.list /etc/apt/sources.list


RUN apt-get update --fix-missing && apt-get install -y wget bzip2 ca-certificates \
    libglib2.0-0 libxext6 libsm6 libxrender1 \
    git mercurial subversion

RUN wget --quiet https://repo.anaconda.com/archive/Anaconda3-5.3.0-Linux-x86_64.sh -O ~/anaconda.sh && \
    /bin/bash ~/anaconda.sh -b -p /opt/conda && \
    rm ~/anaconda.sh && \
    ln -s /opt/conda/etc/profile.d/conda.sh /etc/profile.d/conda.sh && \
    echo ". /opt/conda/etc/profile.d/conda.sh" >> ~/.bashrc && \
    echo "conda activate base" >> ~/.bashrc

RUN apt-get install -y curl grep sed dpkg && \
    TINI_VERSION=`curl https://github.com/krallin/tini/releases/latest | grep -o "/v.*\"" | sed 's:^..\(.*\).$:\1:'` && \
    curl -L "https://github.com/krallin/tini/releases/download/v${TINI_VERSION}/tini_${TINI_VERSION}.deb" > tini.deb && \
    dpkg -i tini.deb && \
    rm tini.deb && \
    apt-get clean



RUN set -x \
        && apt-get update -y \
        && pip install --upgrade pip \
        && pip install mglearn \
	    && pip uninstall urllib3 -y \
	    && pip install runipy \
	    && apt install gcc -y \
	    && pip install mysql-connector-python  \
	    #&& pip install default-libmysqlclient-dev  \
		&& pip uninstall  chardet -y && pip install requests \
		&& conda install jupyter -y --quiet \
        && apt-get clean
WORKDIR /data


COPY ./data/crontab /etc/cron.d/backup-cron
RUN chmod 0644 /etc/cron.d/backup-cron && \
  touch /var/log/cron.log

COPY ./data/scripts /scripts
RUN touch /var/log/cron-stdout.log

CMD env > /root/env && sed -i '/GPG_KEYS/d' /root/env && sed -i '/no_proxy/d' /root/env && sed -i -e 's/^/export /' /root/env && chmod +x /root/env && rsyslogd && cron && tail -F /var/log/syslog /var/log/cron-stdout.log

#ENTRYPOINT ["cron", "-f", "-d", "8"]
#ENTRYPOINT [ "/usr/sbin/cront", "--" ]
CMD [ "/bin/bash" ]