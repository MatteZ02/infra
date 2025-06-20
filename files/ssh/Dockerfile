FROM docker.io/library/debian

RUN apt update && \
    apt install -y openssh-server rsync git

RUN rm -rf /etc/ssh/ssh_host* && \
    mkdir -p /run/sshd

COPY entrypoint.sh /

RUN chmod +x entrypoint.sh

COPY sshd_config /etc/ssh/sshd_config

CMD ./entrypoint.sh
