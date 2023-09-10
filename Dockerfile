FROM alpine

RUN apk update && \
    apk upgrade && \
    apk add openssh-server && \
    rm -rf /var/cache/apk

RUN cat /etc/ssh/sshd_config | grep -v "^#" | grep -v "^$" > /sshd_config && \
    echo "PermitRootLogin yes" >> /sshd_config && \
    echo "PrintMotd no" >> /sshd_config && \
    rm -rf /etc/ssh /root && \
    ln -s /data/ssh /etc/ssh && \
    ln -s /data/root /root && \
    ln -s /data/log /var/log

ENTRYPOINT /entry.sh
VOLUME /data

COPY ./entry.sh /
