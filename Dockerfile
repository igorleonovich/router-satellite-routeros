FROM ubuntu:22.04

RUN echo 'APT::Install-Suggests "0";' >> /etc/apt/apt.conf.d/00-docker
RUN echo 'APT::Install-Recommends "0";' >> /etc/apt/apt.conf.d/00-docker
RUN DEBIAN_FRONTEND=noninteractive \
  apt-get update \
  && apt-get install -y openssh-server \
  && rm -rf /var/lib/apt/lists/*
RUN useradd -ms /bin/bash apprunner
USER apprunner

# RUN cat /etc/ssh/sshd_config | grep -v "^#" | grep -v "^$" > /sshd_config && \
#     echo "PermitRootLogin yes" >> /sshd_config && \
#     echo "PrintMotd no" >> /sshd_config && \
#     rm -rf /etc/ssh /root && \
#     ln -s /data/ssh /etc/ssh && \
#     ln -s /data/root /root && \
#     ln -s /data/log /var/log

COPY ./router-satellite-swift /router-satellite-swift
COPY --chown=apprunner:apprunner ./entry.sh /entry.sh
ENTRYPOINT /entry.sh

# CMD ["echo", "hi"]
# CMD ["./router-satellite-swift"]
