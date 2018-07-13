FROM alpine:3.8

LABEL maintainer="Stefano Gabrye"
LABEL name="tordock"

RUN echo '@edge http://dl-cdn.alpinelinux.org/alpine/edge/community' >> /etc/apk/repositories && \
    apk -U upgrade && \
    apk -v add tor@edge curl && \
    rm -rf /var/cache/apk/*

COPY torrc /etc/tor/

EXPOSE 9150

CMD ["/usr/bin/tor", "-f", "/etc/tor/torrc"]