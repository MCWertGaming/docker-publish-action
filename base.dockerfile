FROM registry.access.redhat.com/ubi8-minimal:latest
RUN curl https://download.docker.com/linux/centos/docker-ce.repo > /etc/yum.repos.d/docker-ce.repo \
    && microdnf install docker-ce-cli
COPY run.sh /run.sh
COPY entrypoint.sh /entrypoint.sh
ENTRYPOINT [ "/entrypoint.sh" ]
