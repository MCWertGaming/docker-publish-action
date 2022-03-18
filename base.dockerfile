FROM alpine:latest

RUN apk --no-cache add docker-cli

COPY run.sh /run.sh
COPY entrypoint.sh /entrypoint.sh

ENTRYPOINT [ "/entrypoint.sh" ]
