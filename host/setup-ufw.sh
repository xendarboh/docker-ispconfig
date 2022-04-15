#!/usr/bin/env bash

# web
ufw allow 20/tcp
ufw allow 21/tcp
ufw allow 2222/tcp
ufw allow 80/tcp
ufw allow 443/tcp
ufw allow 40110:40210/udp
ufw allow 40110:40210/tcp

# mail
ufw allow 25/tcp
ufw allow 110/tcp
ufw allow 143/tcp
ufw allow 465/tcp
ufw allow 587/tcp
ufw allow 993/tcp
ufw allow 995/tcp

# DNS
ufw allow 53/udp

# panels
ufw allow 8080/tcp
ufw allow 8081/tcp

ufw show added
ufw enable
