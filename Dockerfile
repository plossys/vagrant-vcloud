FROM ubuntu

ENV	\
  VAGRANT_VERSION=1.9.3 \
  BOX_WINDOWS=https://raw.githubusercontent.com/plossys/vagrant-vcloud/my/helper/dummy-windows.box \
  BOX_LINUX=https://raw.githubusercontent.com/plossys/vagrant-vcloud/my/helper/dummy-linux.box

COPY vagrant-vcloud-0.4.7.1.gem /

RUN apt-get update -y && \
    apt-get install -y build-essential liblzma-dev zlib1g-dev git openssh-client rsync curl && \
    ln -sf bash /bin/sh && \
    curl -L https://releases.hashicorp.com/vagrant/${VAGRANT_VERSION}/vagrant_${VAGRANT_VERSION}_x86_64.deb > /tmp/vagrant_x86_64.deb && \
    dpkg -i /tmp/vagrant_x86_64.deb && \
    rm -f /tmp/vagrant_x86_64.deb && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* && \
    vagrant plugin install vagrant-reload && \
    vagrant plugin install vagrant-hostmanager && \
    vagrant plugin install vagrant-vcloud-0.4.7.1.gem && \
    ln -s /user/Vagrantfile /root/.vagrant.d/Vagrantfile && \
    vagrant box add windows_7 ${BOX_WINDOWS} && \
    vagrant box add windows_81 ${BOX_WINDOWS} && \
    vagrant box add windows_10 ${BOX_WINDOWS} && \
    vagrant box add windows_2008_r2 ${BOX_WINDOWS} && \
    vagrant box add windows_2012 ${BOX_WINDOWS} && \
    vagrant box add windows_2012_r2 ${BOX_WINDOWS} && \
    vagrant box add windows_2016 ${BOX_WINDOWS} && \
    vagrant box add windows_2016_docker ${BOX_WINDOWS} && \
    vagrant box add ubuntu1404 ${BOX_LINUX} && \
    vagrant box add ubuntu1404-desktop ${BOX_LINUX} && \
    vagrant box add boxcutter/ubuntu1604 ${BOX_LINUX} && \
    vagrant box add boxcutter/ubuntu1604-desktop ${BOX_LINUX} && \
    rm -rf /root/.vagrant.d/gems/gems/vagrant-vcloud-*

COPY helper/retrieve-vagrant-vcloud-settings.sh /usr/local/bin/retrieve-vagrant-vcloud-settings.sh
RUN curl -sL https://deb.nodesource.com/setup_6.x | bash - && \
    apt-get install -y nodejs python python-pip jq && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* && \
    pip install --upgrade httpie && \
    npm install -g xml2json-command

WORKDIR "/work"

VOLUME ["/work", "/user"]

ENV VAGRANT_DEFAULT_PROVIDER vcloud

ENTRYPOINT ["vagrant"]
