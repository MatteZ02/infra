FROM docker.io/library/debian:latest

RUN apt update && \
    apt install -y openssh-server rsync git python3-pip python3-venv jq git curl lsb-release nano

RUN apt-get clean && \
    rm -rf /var/lib/apt/lists/*

RUN rm -rf /etc/ssh/ssh_host* && \
    mkdir -p /run/sshd

COPY entrypoint.sh /

RUN chmod +x entrypoint.sh

COPY sshd_config /etc/ssh/sshd_config

RUN python3 -m venv /opt/ansible && \
    /opt/ansible/bin/pip3 install ansible && \
    /opt/ansible/bin/pip3 install cryptography dnspython hvac jmespath netaddr pexpect

CMD ./entrypoint.sh
