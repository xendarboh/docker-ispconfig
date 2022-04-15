export COMPOSE_PROJECT_NAME=server1.example.com
export HOSTNAME=server1.example.com
export HOST_DIR=/srv/ispconfig/server1.example.com
export OPTIONS_ISPCONFIG="--no-mailman"
export PKGS="whois"
