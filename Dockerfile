FROM ubuntu:jammy

ENV DEBIAN_FRONTEND noninteractive
ENV CRAN_URL https://cloud.r-project.org/
ENV USER=sccity
ENV GROUPNAME=$USER

USER root

RUN set -e \
    && ln -sf bash /bin/sh
      
RUN set -eo pipefail \
    && groupadd $GROUPNAME \
    && useradd -m -d /home/$USER -g $GROUPNAME $USER \
    && echo $USER:$USER | chpasswd
      
WORKDIR /app
RUN chown -R "$USER":"$GROUPNAME" /app && chmod -R 775 /app

RUN set -e \
    && apt-get -y update \
    && apt-get -y dist-upgrade \
    && apt-get -y install --no-install-recommends --no-install-suggests \
                  apt-transport-https \
                  apt-utils \
                  ca-certificates \
                  curl \
                  software-properties-common \
                  git-all \
                  zip \
                  nano \
    && apt-get -y autoremove \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*
    
RUN echo "deb [arch=amd64 trusted=yes] https://download.docker.com/linux/ubuntu jammy stable" > /etc/apt/sources.list.d/docker.list

RUN set -e \
    && apt-get -y update \
    && apt-get -y install docker-ce
    
CMD ["/usr/bin/dockerd"]