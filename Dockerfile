FROM debian:buster-slim

RUN  apt-get update 
RUN  apt-get -y install \
  systemd \
  build-essential \
  vim \
  curl \
  gcc \
  flex \
  bison \
  wget \
  iputils-ping \
  iproute2 \
  net-tools \
  dnsutils \
  nmap \
  lsof \
  procps \
  tcpdump \
  nano \
  cron \
  sudo \
  pkg-config

RUN  apt-get -y install \
  libpcap0.8 \
  libpcap0.8-dev \
  libpcre3 \
  libpcre3-dev \
  libdumbnet1 \
  libdumbnet-dev \
  libdaq2 \
  libdaq-dev

RUN  apt-get -y install \
  zlib1g \
  zlib1g-dev \
  liblzma5 \
  liblzma-dev \
  luajit \
  libluajit-5.1-dev \
  libssl1.1 \
  libssl-dev \
  tcpreplay && \
  apt-get clean

RUN apt-get install -y \
  python \
  python-dev \
  libpython-dev \
  python-pip \
  python-setuptools \
  python-wheel \
  python-distorm3 \
  yara \
  python-pycryptodome \
  python-pycryptodome-doc \
  python-pil \
  python-openpyxl \
  python-ipython \
  python-ujson \
  python-pefile \
  sleuthkit


RUN apt-get install -y \
  python3-pycryptodome \
  python3-pefile \
  python3-pycryptodome \
  python3-yara \
  python3-capstone \
  python3-pip


RUN apt-get install -y \
  git \
  binwalk \
  foremost \
  hashcat \
  netcat

RUN mkdir /root/TP

RUN cd /root/TP; \
	git clone https://github.com/00xBAD/kali-wordlists.git

RUN cd /root/TP/kali-wordlists; gunzip rockyou.txt.gz

RUN cd /root/TP; \
	git clone https://github.com/danielmiessler/SecLists.git

RUN cd /root/TP; \
	git clone https://github.com/volatilityfoundation/volatility.git

RUN cd /root/TP/volatility; \
	python setup.py install


RUN cd /root/TP; \
	git clone https://github.com/volatilityfoundation/volatility3.git 

RUN cd /root/TP/volatility; \
	pip3 install -r requirements.txt; \
	python3 setup.py build; \
	python setup.py install

RUN cd /root; \
	pip3 install --upgrade pip

RUN cd /root; \
	pip3 install -U oletools

RUN echo "alias ls='ls $LS_OPTIONS'" >> /root/.bashrc
RUN echo "alias ll='ls $LS_OPTIONS -l'" >> /root/.bashrc
RUN echo "alias l='ls $LS_OPTIONS -lA'" >> /root/.bashrc

RUN echo "alias rm='rm -i'" >> /root/.bashrc
RUN echo "alias cp='cp -i'" >> /root/.bashrc
RUN echo "alias mv='mv -i'" >> /root/.bashrc
RUN echo "cd /root/TP" >> /root/.bashrc

RUN mkdir /home/root2; \
        groupadd -g 666 root2; \
        useradd -u 666 -g 666 -c "catch me if you can" -d /home/root2 -s /bin/bash root2; \
        chown -R root2:root2 /home/root2

RUN echo 'root2:killbill' | chpasswd
RUN usermod -aG sudo root2

RUN apt-get -y install apache2
COPY FILES/ /
RUN chown -R www-data:www-data /var/www
RUN chmod -R 777 /var/www/html/uploads
RUN chmod 700 /root/.ssh
RUN chmod 600 /root/.ssh/authorized_keys

# To run in the container
#systemctl daemon-reload
#systemctl start IpManager
#systemctl enable IpManager


