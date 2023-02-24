# koha-dockerization
A docker image for Hive13's Koha instance

This is a work in progress and the running container requires 
some initialization commands when installing a new koha instance.

## Building & Running

### Build the Docker image
```shell
docker build -t koha-test .
```

### Prepare local directories for persistant data

```shell
mkdir ./working-data/sql-data
sudo chown -R 101:101 ./working-data/sql-data
sudo chmod -R g+rw ./working-data/sql-data
```

Note: uid(101) and gid(101) map to the mysql user & group on the container

### Start the container
```shell
./startup.sh
```
