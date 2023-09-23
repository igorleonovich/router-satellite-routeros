FROM alpine

RUN mkdir -p /root/.ssh && \
    chmod 0700 /root/.ssh && \
    apk add --update --no-cache openssh && \
    ssh-keygen -A && \
    echo -e "PermitRootLogin yes" >> /etc/ssh/sshd_config && \
    echo -e "PasswordAuthentication no" >> /etc/ssh/sshd_config

COPY ./Private/router-satellite-alpine.pub /root/.ssh/authorized_keys
RUN chmod 0600 /root/.ssh/authorized_keys

ENTRYPOINT ["/usr/sbin/sshd", "-D", "-e"]

EXPOSE ${SSH_INTERNAL_PORT}
