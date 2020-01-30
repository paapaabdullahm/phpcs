FROM pam79/php-fpm:v7.4.1
LABEL maintainer="Paapa Abdullah Morgan <paapaabdullahm@gmail.com>"

# Install php-codesniffer package
RUN set -eux; \
    apt update; \
    apt install -y php-codesniffer; \
    rm -rf /var/lib/apt/lists/*

WORKDIR /src
VOLUME /src

CMD ["phpcs"]
