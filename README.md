# koha-dockerization
A docker image for Hive13's Koha instance

This is a work in progress and the running container requires 
some initialization commands when installing a new koha instance.

## Building & Running

### Build the Docker image
```shell
docker build -t koha-test .
```

### Prepare local directories & permissions for persistant data

```shell
mkdir -p ./working-data/sql-data
mkdir -p ./working-data/koha-data
mkdir -p ./working-data/koha-config
mkdir -p ./working-data/sites-available
sudo chown -R 101:101 ./working-data/sql-data
sudo chown -R 1001:1001 ./working-data/koha-data
sudo chown -R 1001:1001 ./working-data/koha-config
sudo chmod -R g+rw ./working-data/sql-data
```

Notes: 

uid(101) and gid(101) map to the mysql user & group on the container

uid(1001) and gid(1001) map to the hive13-koha user & group on the container

### Start the container
```shell
./startup.sh
```
