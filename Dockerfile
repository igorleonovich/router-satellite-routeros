FROM alpine

RUN mkdir -p /root/.ssh && \
    chmod 0700 /root/.ssh && \
    apk add --update --no-cache openssh nano htop && \
    ssh-keygen -A && \
    echo "PermitRootLogin yes" >> /etc/ssh/sshd_config && \
    echo "PasswordAuthentication no" >> /etc/ssh/sshd_config

COPY ./Private/key.pub /root/.ssh/authorized_keys
RUN chmod 0600 /root/.ssh/authorized_keys

COPY ./Private/mkr /root/.ssh/mkr
RUN chmod 0600 /root/.ssh/mkr

COPY ./Private/config /root/.ssh/config
RUN chmod 0600 /root/.ssh/config

# TODO: Use variables
RUN ssh-keyscan -p 50022 192.168.88.1 >> /root/.ssh/known_hosts

ENTRYPOINT ["/usr/sbin/sshd", "-D", "-e"]

EXPOSE ${SSH_INTERNAL_PORT}
