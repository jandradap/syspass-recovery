# syspass-recovery [![](https://images.microbadger.com/badges/image/jorgeandrada/syspass-recovery:latest.svg)](https://microbadger.com/images/jorgeandrada/syspass-recovery:latest "Get your own image badge on microbadger.com")[![](https://images.microbadger.com/badges/version/jorgeandrada/syspass-recovery:latest.svg)](https://microbadger.com/images/jorgeandrada/syspass-recovery:latest "Get your own version badge on microbadger.com")[![](https://images.microbadger.com/badges/commit/jorgeandrada/syspass-recovery:latest.svg)](https://microbadger.com/images/jorgeandrada/syspass-recovery:latest "Get your own commit badge on microbadger.com")

This image allows you to build a backup of syspass in case of catastrophe.
You only need the dump of the syspass database, the config.xml (sysPass/config/config.xml) file and the docker-compose.yml of this repository.

## Modify files to recover
### Config file
Change these parameters in config.xml
```xml
  <dbHost>db</dbHost>
  <dbName>syspass</dbName>
  <dbPass>XXXXXXXXXXXXXXXXXXXXXXX</dbPass>
  <httpsEnabled>1</httpsEnabled>
```
to:
```xml
  <dbHost>syspass</dbHost>
  <dbName>syspass</dbName>
  <dbPass>PaSsword12345_23</dbPass>
  <httpsEnabled>0</httpsEnabled>
```

### Database
Rename syspass database backup to db.sql

## Start
```shell
wget https://github.com/jandradap/syspass-recovery/blob/master/docker-compose.yml
#modify config.xml
#rename syspassdb backup to db.sql
docker-compose -p syspass-recovery -f docker-compose.yml up -d #start
docker-compose -p syspass-recovery -f docker-compose.yml down #stop
```

## Info
- **sysPass info:** [http://www.syspass.org](http://www.syspass.org)
- **Install docker-compose:** [https://docs.docker.com/compose/install/](https://docs.docker.com/compose/install/)
- **Install docker** [https://www.docker.com/community-edition#/download](https://www.docker.com/community-edition#/download)
