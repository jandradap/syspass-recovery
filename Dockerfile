FROM debian:stretch-slim

ARG BUILD_DATE
ARG VCS_REF
ARG VERSION
LABEL org.label-schema.build-date=$BUILD_DATE \
			org.label-schema.name="syspass-recovery" \
			org.label-schema.description="sysPass recovery image" \
			org.label-schema.url="http://andradaprieto.es" \
			org.label-schema.vcs-ref=$VCS_REF \
			org.label-schema.vcs-url="https://github.com/jandradap/syspass-recovery" \
			org.label-schema.vendor="Jorge Andrada Prieto" \
			org.label-schema.version=$VERSION \
			org.label-schema.schema-version="1.0" \
			maintainer="Jorge Andrada Prieto <jandradap@gmail.com>" \
			org.label-schema.docker.cmd=""

RUN echo 'debconf debconf/frontend select Noninteractive' | debconf-set-selections

RUN apt-get update && apt-get -y install --no-install-recommends \
  locales apache2 libapache2-mod-php5 php5 php5-curl php5-mysqlnd php5-gd \
  php5-json php5-ldap php5-mcrypt wget unzip vim mariadb-client \
  && apt-get clean \
  && rm -r /var/lib/apt/lists/*

WORKDIR /var/www/html

COPY ./files/000-default.conf ./files/default-ssl.conf /etc/apache2/sites-available/

COPY ./files/entrypoint.sh /usr/local/sbin/

# Download and install the latest sysPass stable release from GitHub
RUN wget https://github.com/nuxsmin/sysPass/archive/master.zip \
  && unzip master.zip \
  && mv sysPass-master sysPass \
  && chmod 750 sysPass/config sysPass/backup \
  && chown www-data -R sysPass/

RUN a2enmod ssl \
  && a2ensite default-ssl \
  && chmod 755 /usr/local/sbin/entrypoint.sh

EXPOSE 80 443

ENTRYPOINT ["/usr/local/sbin/entrypoint.sh"]
