#!/bin/bash

setup_locales() {
  if [ ! -e ".setup" ]; then
    LOCALE_GEN="/etc/locale.gen"

    echo -e "\nSetting up locales ..."

    echo -e "\n### sysPass locales" >> $LOCALE_GEN
    echo "es_ES.UTF-8 UTF-8" >> $LOCALE_GEN
    echo "en_US.UTF-8 UTF-8" >> $LOCALE_GEN
    echo "de_DE.UTF-8 UTF-8" >> $LOCALE_GEN
    echo "ca_ES.UTF-8 UTF-8" >> $LOCALE_GEN
    echo "fr_FR.UTF-8 UTF-8" >> $LOCALE_GEN
    echo "ru_RU.UTF-8 UTF-8" >> $LOCALE_GEN

    echo 'LANG="en_US.UTF-8"' > /etc/default/locale

    dpkg-reconfigure --frontend=noninteractive locales
    update-locale LANG=en_US.UTF-8

    LANG=en_US.UTF-8

    echo "1" > .setup
 fi
}

[[ -e "/var/run/apache2/apache2.pid" ]] && rm -rf "/var/run/apache2/apache2.pid"

trap "echo 'Stopping Apache2 ...' && /usr/sbin/apachectl stop" HUP INT QUIT KILL TERM

setup_locales

cp /root/config.xml /var/www/html/sysPass/config/
chown -R www-data /var/www/html/sysPass/config
chmod -R 750 /var/www/html/sysPass/config

echo -e "Starting Apache2 ...\n"
/usr/sbin/apache2ctl -D FOREGROUND &

wait $!
