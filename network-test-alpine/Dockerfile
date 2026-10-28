FROM alpine:3.19
RUN apk add --no-cache bash netcat-openbsd
COPY net-test.sh /net-test.sh
RUN chmod +x /net-test.sh
ENTRYPOINT ["/net-test.sh"]
