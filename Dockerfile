FROM alpine

ARG SSH_FILE_NAME

COPY ./Private/.env /tmp/.env

RUN export $(grep -v '^#' /tmp/.env | xargs) && \
    mkdir -p /root/.ssh && \
    chmod 0700 /root/.ssh && \
    apk add --update --no-cache openssh nano htop && \
    ssh-keygen -A && \
    echo "PermitRootLogin yes" >> /etc/ssh/sshd_config && \
    echo "PasswordAuthentication no" >> /etc/ssh/sshd_config && \
    echo "Port $CONTAINER_INTERNAL_SSH_PORT" >> /etc/ssh/sshd_config && \
    ssh-keyscan -p $ROUTER_SSH_PORT $ROUTER_IP >> /root/.ssh/known_hosts

COPY ./Private/container-ssh-key.pub /root/.ssh/authorized_keys
RUN chmod 0600 /root/.ssh/authorized_keys

COPY ./Private/router-ssh-key /root/.ssh/${SSH_FILE_NAME}
RUN chmod 0600 /root/.ssh/${SSH_FILE_NAME}

COPY ./Private/config /root/.ssh/config
RUN chmod 0600 /root/.ssh/config

RUN rm /tmp/.env

ENTRYPOINT ["/usr/sbin/sshd", "-D", "-e"]

EXPOSE ${CONTAINER_INTERNAL_SSH_PORT}