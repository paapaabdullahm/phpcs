#!/usr/bin/expect

# Auto download and install pear binary
spawn wget -O /tmp/go-pear.phar http://pear.php.net/go-pear.phar
expect eof

spawn php /tmp/go-pear.phar

expect "1-11, 'all' or Enter to continue:"
send "\r"
expect eof
