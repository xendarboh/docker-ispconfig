# Dockerized ISPConfig

Supports a single docker container running per host with a docker image custom
built for a particular [ISPConfig](https://www.ispconfig.org/) installation.

See `host/env/server1.example.com` for an example configuration file.

See `.env` and `docker-compose.yml` for more configuration options.

See `$ make help` for a list of make targets, mostly supportive of Dockerfile development.

Run `host/setup-ufw.sh` to configure ufw firewall rules on the host.

Run `host/run-ispconfig.sh <env file>` to build and run a dockerized ISPConfig
installation using options specified in the env file with docker volumes
initialized from the docker image. For example:

```bash
host/run-ispconfig.sh host/env/server1.example.com
```
