#!/bin/bash

docker run \
  --rm \
  -it \
  --cap-add=SYS_NICE \
  --cap-add=DAC_READ_SEARCH \
  --cap-add=DAC_OVERRIDE \
  --name koha-test \
  -v $(pwd)/working-data/sql-data:/var/lib/mysql \
  -v $(pwd)/working-data/koha-data:/var/lib/koha \
  -v $(pwd)/working-data/koha-config:/etc/koha \
  -v $(pwd)/working-data/sites-available:/etc/apache2/sites-available \
  -p 7001:80 \
  -p 7002:8080 \
  -p 7003:3306 \
  koha-test


#  -v $(pwd)/working-data/sql-data:/var/lib/mysql \
#  -v $(pwd)/working-data/koha-data:/var/lib/koha \
