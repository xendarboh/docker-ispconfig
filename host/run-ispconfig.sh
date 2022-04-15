#!/usr/bin/env bash
test -z "${1}" && echo "USAGE: $0 <env_file>" && exit 1

ENV=${1}
test ! -f ${ENV} && echo "environment file not found: ${ENV}" && exit 1

source $(dirname $0)/../.env
source ${ENV}

cd $(dirname $0)/..
docker-compose --profile build build

# initialize data directory if not exists
if [ ! -d ${HOST_DIR} ]
then
    echo "Init data directory: ${HOST_DIR}"
    mkdir -p ${HOST_DIR}/srv
    docker run -it --rm \
        -v ${HOST_DIR}:/host \
        --entrypoint /bin/bash \
        ${REPO}/ispconfig-${HOSTNAME}:${TAG} \
        -c '\
          cp -a --parents \
              /etc \
              /root/.acme.sh \
              /var/lib/mysql \
              /var/log \
              /var/mail \
              /var/vmail \
              /var/www \
            /host/ ; \
          '
fi

docker-compose --profile run up -d
