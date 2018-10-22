FROM alpine:3.4 AS downloader

RUN apk --no-cache add ca-certificates openssl && update-ca-certificates

ARG VERSION
RUN wget -O fly https://github.com/concourse/fly/releases/download/v${VERSION}/fly_linux_amd64 && chmod +x fly 

# FROM scratch
FROM alpine:3.4
COPY --from=downloader fly /usr/local/bin/fly
COPY scripts /usr/local/bin/

CMD ["/usr/local/bin/fly"]