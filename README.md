# PHPCS
PHP_CodeSniffer is a set of two PHP scripts; the main phpcs script that tokenizes PHP, JavaScript and CSS files to detect violations of a defined coding standard, and a second phpcbf script to automatically correct coding standard violations. PHP_CodeSniffer is an essential development tool that ensures your code remains clean and consistent.

Current Tags: **v3.2.3** (stable)

## Usage

#### Via Docker Run

```sh
$ docker run --rm -it -v "$(pwd)":/src -w /src "pam79/phpcs --version
```

#### Via a Wrapper Script

Make a directory for holding your script
```sh
$ mkdir -p Scripts
```

Add a file for tracking the version of the docker image being used
```sh
$ vim Scripts/VERSION
```

Add the following content to the version file
```sh
PHPCS=v3.2.3
```

Next, create the main phpcs.sh script
```sh
$ vim Scripts/phpcs.sh
```

Then add the following content to the script
```sh
#!/bin/sh

# A wrapper script for invoking PHP_CodeSniffer with docker
# Put this script in your $PATH as `phpcs`

VERSION_FILE="${HOME}/Scripts/VERSION"
VERSION=`awk -F = '/PHPCS/{print $2}' "${VERSION_FILE}"`;

TTY_FLAG=``

if [ -t 1 ]; then TTY_FLAG="-t"; fi

exec docker run --rm -i ${TTY_FLAG} \
    --volume "$PWD":/src \
    --workdir /src \
    --user $(id -u):$(id -g) \
    "pam79/phpcs:${VERSION}" "$@";
```

Ensure the phpcs script is locally installed
```sh
$ sudo install -m 0775 Scripts/phpcs.sh /usr/local/bin/phpcs
```

Finally, test the newly installed phpcs script
```sh
$ phpcs --version
```
