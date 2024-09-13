FROM alpine

# Install necessary packages, including gettext for envsubst and bash
RUN apk add --update --no-cache openssh nano htop gettext bash

# Define build arguments as environment variables
ARG CONTAINER_SSH_FILE_NAME
ARG CONTAINER_INTERNAL_SSH_PORT
ARG ROUTER_SSH_PORT
ARG ROUTER_SSH_IP
ARG ROUTER_SSH_FILE_NAME

# Set up SSH server
RUN mkdir -p /root/.ssh && \
    chmod 0700 /root/.ssh

# Copy the SSH public key and set permissions
# [TODO] Use variables for SSH key names
COPY ./Private/container-ssh-key.pub /root/.ssh/authorized_keys
RUN chmod 0600 /root/.ssh/authorized_keys

# Copy the SSH private key and rename it based on the environment variable
# [TODO] Use variables for SSH key names
COPY ./Private/router-ssh-key /root/.ssh/router-ssh-key
RUN chmod 0600 /root/.ssh/router-ssh-key

# Configure SSH server
RUN echo "PermitRootLogin yes" >> /etc/ssh/sshd_config && \
    echo "PasswordAuthentication no" >> /etc/ssh/sshd_config && \
    echo "Port ${CONTAINER_INTERNAL_SSH_PORT}" >> /etc/ssh/sshd_config

# Pre-connect to router by adding its SSH key to known_hosts
RUN echo "Running ssh-keyscan for ${ROUTER_SSH_IP}:${ROUTER_SSH_PORT}" && \
    if [ -n "${ROUTER_SSH_PORT}" ] && [ -n "${ROUTER_SSH_IP}" ]; then \
        ssh-keyscan -p ${ROUTER_SSH_PORT} ${ROUTER_SSH_IP} >> /root/.ssh/known_hosts || echo "ssh-keyscan failed, continuing without it"; \
    fi

# Set up SSH config with variable substitution
COPY ./Private/config.template /root/.ssh/config.template
RUN envsubst < /root/.ssh/config.template > /root/.ssh/config && \
    chmod 0600 /root/.ssh/config

# Clean up only if files exist
RUN rm -f /tmp/.env || true
RUN rm -f /root/.ssh/config.template || true

ENTRYPOINT ["/usr/sbin/sshd", "-D", "-e"]

# Expose the internal SSH port
EXPOSE ${CONTAINER_INTERNAL_SSH_PORT}