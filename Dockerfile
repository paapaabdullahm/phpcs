FROM pam79/php-fpm:v7.4.1
LABEL maintainer="Paapa Abdullah Morgan <paapaabdullahm@gmail.com>"

# Install the expect package as a dependency
RUN set -eux; \
    apt update; \
    apt install -y expect git; \
    rm -rf /var/lib/apt/lists/*

COPY ./expect-install-pear.sh ./

# Install pear, phpcs and wpcs packages
RUN chmod 744 ./expect-install-pear.sh; \
    ./expect-install-pear.sh; \
    pear install PHP_CodeSniffer; \
    git clone -b master https://github.com/WordPress/WordPress-Coding-Standards.git /wpcs; \
    chmod -R 777 /wpcs; phpcs --config-set installed_paths /wpcs; \
    rm expect-install-pear.sh; \
    rm /tmp/go-pear.phar

WORKDIR /src
VOLUME /src

ENTRYPOINT ["/usr/local/bin/phpcs"]
CMD ["phpcs"]
