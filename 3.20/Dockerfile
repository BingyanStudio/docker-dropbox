FROM alpine:3.3

ENV DROPBOX_VERSION 3.20.1

RUN deps='curl ca-certificates' && \
    apk --no-cache add $deps 'python<2.8' && \
    # install glibc
    cd /tmp && \
       wget -q -O /etc/apk/keys/sgerrand.rsa.pub \
            https://raw.githubusercontent.com/sgerrand/alpine-pkg-glibc/master/sgerrand.rsa.pub && \
       wget https://github.com/sgerrand/alpine-pkg-glibc/releases/download/2.23-r3/glibc-2.23-r3.apk && \
       apk add glibc-2.23-r3.apk && \
       curl -SL "https://d1ilhw0800yew8.cloudfront.net/client/dropbox-lnx.x86_64-3.20.1.tar.gz" | tar xzf - && \
       mv .dropbox-dist / && \
       ln -sf /.dropbox-dist/dropboxd /usr/bin/ && \
       curl -SL "https://www.dropbox.com/download?dl=packages/dropbox.py" -o /usr/bin/dropboxctl && \
       chmod +x /usr/bin/dropboxctl && \
    # cleanup
    cd / && rm -rf /tmp/* && \
    apk del $deps

ENV UID 1000
ENV GID 1000

ADD ./docker-entrypoint.sh /
ENTRYPOINT ["/docker-entrypoint.sh"]
VOLUME ["/Dropbox"]

CMD ["dropboxd"]
