FROM alpine:3.15.2

RUN apk --no-cache add docker-cli

COPY run.sh /run.sh
COPY entrypoint.sh /entrypoint.sh

ENTRYPOINT [ "/entrypoint.sh" ]
