FROM    alpine:3.7

# Prepare environment
RUN     addgroup adminer
RUN     adduser -h /app -D -G adminer adminer
RUN     mkdir -p /app
RUN     chown adminer:adminer /app
WORKDIR /app
ENV     ADMINER_VERSION 4.6.2

# Install
RUN     apk update && \
        apk upgrade && \
        # Install require packages
        apk add curl ca-certificates && \
        apk add libcap \
                php5 \
                php5-cli \
                php5-mssql \
                php5-mysqli \
                php5-pgsql \
                php5-sqlite3 && \
        # Install Adminer
        curl https://www.adminer.org/static/download/${ADMINER_VERSION}/adminer-${ADMINER_VERSION}.php -s -S -o index.php && \
        # Allow PHP to run as a service
        setcap CAP_NET_BIND_SERVICE=+eip /usr/bin/php5 && \
        # Clean
        apk del libcap curl ca-certificates && \
        rm -rf /var/cache/apk/*

EXPOSE   80

USER     adminer
CMD      ["/usr/bin/php5", "-S", "0.0.0.0:80", "-t", "/app"]
