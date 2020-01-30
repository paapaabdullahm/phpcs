FROM pam79/php-fpm:v7.4.1
LABEL maintainer="Paapa Abdullah Morgan <paapaabdullahm@gmail.com>"

# Install the expect package as a dependency
RUN set -eux; \
    apt update; \
    apt install -y expect; \
    rm -rf /var/lib/apt/lists/*

COPY ./expect-install-pear.sh ./

# Install pear and php-codesniffer packages
RUN chmod 744 ./expect-install-pear.sh; \
    ./expect-install-pear.sh; \
    pear install PHP_CodeSniffer; \
    rm expect-install-pear.sh; \
    rm /tmp/go-pear.phar

WORKDIR /src
VOLUME /src

CMD ["phpcs"]
