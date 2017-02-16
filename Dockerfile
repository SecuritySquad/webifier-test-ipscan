FROM debian:jessie
#BRO
RUN apt-get update \
    && apt-get install -y curl \
    && curl -sSL http://download.opensuse.org/repositories/network:bro/Debian_8.0/Release.key | apt-key add - \
    && echo 'deb http://download.opensuse.org/repositories/network:/bro/Debian_8.0/ /' > /etc/apt/sources.list.d/bro.list \
    && apt-get update \
    && apt-get install -y bro \
    && rm -rf /var/lib/apt/lists/*
RUN echo 'export PATH=/opt/bro/bin:$PATH' >> /root/.bashrc

VOLUME /opt/bro/logs
WORKDIR /opt/bro/logs
ENV PATH /opt/bro/bin:$PATH
COPY phantomjs-2.1.1-linux-x86_64.tar.bz2 /
#PHANTOMJS
RUN apt-get update \
 && apt-get -y install build-essential chrpath libssl-dev libxft-dev \
 && apt-get -y install libfreetype6 libfreetype6-dev \
 && apt-get -y install libfontconfig1 libfontconfig1-dev wget \
 && cd / \
 && export PHANTOM_JS="phantomjs-2.1.1-linux-x86_64" \
 && tar xvjf $PHANTOM_JS.tar.bz2 \
 && mv $PHANTOM_JS /usr/local/share \
 && ln -sf /usr/local/share/$PHANTOM_JS/bin/phantomjs /usr/local/bin
 #PYTHON
 RUN apt-get install python

COPY open.js /
COPY netsniff.js /
COPY entrypoint.sh /
COPY init.bro /logs/
COPY validate.py /

RUN ["chmod", "+x", "/entrypoint.sh"]

ENTRYPOINT ["/entrypoint.sh"]
