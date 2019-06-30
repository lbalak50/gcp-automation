# gcp-automation
Google cloud automation scripts

```
$ git clone https://github.com/tensult/gcp-automation.git
```

## Postgres data migration
### Prerequisites
Install Postgres client in your machine.

### Dump Postgres data
```
$ HOST=<host> USERNAME=<username> DATABASES=<database1>,<database2>,.. FOLDER=<folder-name> PGPASSWORD=<password> sh dump-postgres-data.sh
```

### Restore Postgres data
```
$ HOST=<host> USERNAME=<username> PGPASSWORD=<password> FOLDER=<folder-name> DEFAULT_DATABASE=<default-database> sh restore-postgres-data.sh
```