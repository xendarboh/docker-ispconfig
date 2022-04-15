# 20220307: ubuntu 20.04 is latest supported ubuntu version
# https://git.ispconfig.org/ispconfig/ispconfig-autoinstaller/-/blob/master/lib/os/class.ISPConfigBaseOS.inc.php#L41
FROM ubuntu:20.04

SHELL ["/bin/bash", "-c"]

ENV DEBIAN_FRONTEND noninteractive

# To support dockerfile development, cache apt package downloads locally
# https://github.com/sameersbn/docker-apt-cacher-ng#usage
ARG DEV_DOCKERFILE=0
RUN if [ "${DOCKERFILE_DEV}" = "1" ]; then \
  echo 'Acquire::HTTP::Proxy "http://172.17.0.1:3142";' >> /etc/apt/apt.conf.d/01proxy \
  && echo 'Acquire::HTTPS::Proxy "false";' >> /etc/apt/apt.conf.d/01proxy \
  ; fi

# set locale
ARG LOCALE=en_US.UTF-8
RUN apt-get update \
  && apt-get install -y --no-install-recommends \
    locales \
  && rm -rf /var/lib/apt/lists/* \
  && locale-gen ${LOCALE} && update-locale LANG=${LOCALE} LC_ALL=${LOCALE}
ENV LANG=${LOCALE} LC_ALL=${LOCALE}

# FIX /etc/resolv.conf: Device or resource busy
# https://github.com/moby/moby/issues/1297#issuecomment-115458690
# https://stackoverflow.com/a/45908415
RUN echo "resolvconf resolvconf/linkify-resolvconf boolean false" | debconf-set-selections

# ISPConfig installer fails with local apt cache (for dev), so explicitly apt-install packages to benefit
# This also installs the "system" PHP and other deps required for ISPConfig installation
RUN apt-get update \
  && apt-get install -y --no-install-recommends \
    # [INFO] Installing packages ssh, openssh-server, nano, vim-nox, lsb-release, apt-transport-https, ca-certificates, wget, git, gnupg, software-properties-common, ntp
    ssh \
    openssh-server \
    nano \
    vim-nox \
    lsb-release \
    apt-transport-https \
    ca-certificates \
    wget \
    git \
    gnupg \
    software-properties-common \
    ntp \
    # [INFO] Installing packages dbconfig-common, postfix, postfix-mysql, postfix-doc, mariadb-client, mariadb-server, openssl, getmail4, rkhunter, binutils, sudo
    dbconfig-common \
    postfix \
    postfix-mysql \
    postfix-doc \
    mariadb-client \
    mariadb-server \
    openssl \
    getmail4 \
    rkhunter \
    binutils \
    sudo \
    # [INFO] Installing packages dovecot-imapd, dovecot-pop3d, dovecot-mysql, dovecot-sieve, dovecot-managesieved, dovecot-lmtpd
    dovecot-imapd \
    dovecot-pop3d \
    dovecot-mysql \
    dovecot-sieve \
    dovecot-managesieved \
    dovecot-lmtpd \
    # [INFO] Installing packages software-properties-common, dnsutils, resolvconf, clamav, clamav-daemon, clamav-docs, zip, unzip, bzip2, xz-utils, lzip, rar, arj, nomarch, lzop, cabextract, apt-listchanges, libnet-ldap-perl, libauthen-sasl-perl, daemon, libio-string-perl, libio-socket-ssl-perl, libnet-ident-perl, libnet-dns-perl, libdbd-mysql-perl, bind9, spamassassin, rspamd, redis-server, postgrey, p7zip, p7zip-full, unrar-free, lrzip
    software-properties-common \
    dnsutils \
    resolvconf \
    clamav \
    clamav-daemon \
    clamav-docs \
    zip \
    unzip \
    bzip2 \
    xz-utils \
    lzip \
    rar \
    arj \
    nomarch \
    lzop \
    cabextract \
    apt-listchanges \
    libnet-ldap-perl \
    libauthen-sasl-perl \
    daemon \
    libio-string-perl \
    libio-socket-ssl-perl \
    libnet-ident-perl \
    libnet-dns-perl \
    libdbd-mysql-perl \
    bind9 \
    spamassassin \
    rspamd \
    redis-server \
    postgrey \
    p7zip \
    p7zip-full \
    unrar-free \
    lrzip \
    # [INFO] Installing packages apache2, apache2-doc, apache2-utils, libapache2-mod-fcgid, apache2-suexec-pristine, libapache2-mod-python, libapache2-mod-passenger
    apache2 \
    apache2-doc \
    apache2-utils \
    libapache2-mod-fcgid \
    apache2-suexec-pristine \
    libapache2-mod-python \
    libapache2-mod-passenger \
    # [INFO] Installing packages php-pear, php-memcache, php-imagick, mcrypt, imagemagick, libruby, memcached, php-apcu, jailkit, php7.4, php7.4-common, php7.4-gd, php7.4-mysql, php7.4-imap, php7.4-cli, php7.4-curl, php7.4-intl, php7.4-pspell, php7.4-sqlite3, php7.4-tidy, php7.4-xmlrpc, php7.4-xsl, php7.4-zip, php7.4-mbstring, php7.4-soap, php7.4-opcache, php7.4-cgi, php7.4-fpm
    php-pear \
    php-memcache \
    php-imagick \
    mcrypt \
    imagemagick \
    libruby \
    memcached \
    php-apcu \
    jailkit \
    php7.4 \
    php7.4-common \
    php7.4-gd \
    php7.4-mysql \
    php7.4-imap \
    php7.4-cli \
    php7.4-curl \
    php7.4-intl \
    php7.4-pspell \
    php7.4-sqlite3 \
    php7.4-tidy \
    php7.4-xmlrpc \
    php7.4-xsl \
    php7.4-zip \
    php7.4-mbstring \
    php7.4-soap \
    php7.4-opcache \
    php7.4-cgi \
    php7.4-fpm \
    # [INFO] Installing packages phpmyadmin
    phpmyadmin \
    # [INFO] Installing packages mailman
    mailman \
    # [INFO] Installing packages quota, quotatool, haveged, geoip-database, libclass-dbi-mysql-perl, libtimedate-perl, build-essential, autoconf, automake, libtool, flex, bison, debhelper, binutils
    quota \
    quotatool \
    haveged \
    geoip-database \
    libclass-dbi-mysql-perl \
    libtimedate-perl \
    build-essential \
    autoconf \
    automake \
    libtool \
    flex \
    bison \
    debhelper \
    binutils \
    # [INFO] Installing packages pure-ftpd-common, pure-ftpd-mysql, webalizer, awstats, goaccess
    pure-ftpd-common \
    pure-ftpd-mysql \
    webalizer \
    awstats \
    goaccess \
    # [INFO] Installing packages fail2ban, ufw
    fail2ban \
    ufw \
    # [INFO] Installing packages roundcube, roundcube-core, roundcube-mysql, roundcube-plugins
    roundcube \
    roundcube-core \
    roundcube-mysql \
    roundcube-plugins \
  && rm -rf /var/lib/apt/lists/*

# 20220308: Fix fatal error during ispconfig install, if apt cache is enabled:
# FIX [ERROR] Exception occured: ISPConfigOSException -> Command while fuser /var/lib/dpkg/lock >/dev/null 2>&1 || fuser /var/lib/apt/lists/lock >/dev/null 2>&1 ; do sleep 2; done; DEBIAN_FRONTEND="noninteractive" apt-get dist-upgrade -o Dpkg::Options::="--force-overwrite" -qq -y 2>&1 failed. (/ispconfig.ai.php:15)
RUN if [ "${DOCKERFILE_DEV}" = "1" ]; then rm -f /etc/apt/apt.conf.d/01proxy; fi

# Install another PHP version in addition to the system PHP version, which is always required
# (fails with apt cache enabled)
ARG VERSION_PHP=8.1
RUN add-apt-repository ppa:ondrej/php \
  && apt-get update \
  && apt-get install -y --no-install-recommends \
    php${VERSION_PHP} \
    php${VERSION_PHP}-common \
    php${VERSION_PHP}-gd \
    php${VERSION_PHP}-mysql \
    php${VERSION_PHP}-imap \
    php${VERSION_PHP}-cli \
    php${VERSION_PHP}-curl \
    php${VERSION_PHP}-intl \
    php${VERSION_PHP}-pspell \
    php${VERSION_PHP}-sqlite3 \
    php${VERSION_PHP}-tidy \
    php${VERSION_PHP}-xsl \
    php${VERSION_PHP}-zip \
    php${VERSION_PHP}-mbstring \
    php${VERSION_PHP}-soap \
    php${VERSION_PHP}-opcache \
    php${VERSION_PHP}-cgi \
    php${VERSION_PHP}-fpm \
    # php7.4-xmlrpc \
  && rm -rf /var/lib/apt/lists/*

ARG HOSTNAME=server1.example.com
ARG OPTIONS_ISPCONFIG=""
RUN \
  # FIX [ERROR] The host name 1f0f37d674ef of your server is no fully qualified domain name (xyz.domain.com). Please check it is correctly set. (/lib/os/class.ISPConfigDebianOS.inc.php:597)
  # FIX [ERROR] Exception occured: ISPConfigOSException -> Host name is no FQDN. (/ispconfig.ai.php:15)
  # https://stackoverflow.com/questions/28898787/how-to-handle-specific-hostname-like-h-option-in-dockerfile
  # https://stackoverflow.com/a/41810877
  mv /usr/bin/hostname{,.bak} \
    && echo "echo ${HOSTNAME}" > /usr/bin/hostname \
    && chmod +x /usr/bin/hostname \
  \
  # FIX freeze after "[INFO] Adding php versions to ISPConfig" and before "[INFO] Checking all services are running."
  # https://git.ispconfig.org/ispconfig/ispconfig-autoinstaller/-/blob/master/lib/os/class.ISPConfigDebianOS.inc.php
  # What's there is $this->startService('rspamd'); and rspamd logs complain of redis not started so wait in the
  # background long enough for the ISPConfig install process to reach the point of freezing, then restart redis and
  # rspamd for it to continue. Required for rspamd (--use-mail) but possibly not --use-amavis.
  && bash -c "sleep 10m && /etc/init.d/redis-server restart && /etc/init.d/rspamd restart &" \
  \
  # install ISPConfig!
  && wget -O - https://get.ispconfig.org \
    # FIX error: cannot open /dev/?: No such file
    | sed -e 's/^TTY=.*/TTY=""/' \
    | sh -s -- \
      --i-know-what-i-am-doing \
      \
      # FIX [ERROR] Exception occured: ISPConfigOSException -> Command update-alternatives --set php-cgi /usr/bin/php-cgi7.4 ; update-alternatives --set php-fpm.sock /run/php/php7.4-fpm.sock failed. (/ispconfig.ai.php:15)
      # https://www.howtoforge.com/community/threads/error-installing-on-debian-11.87873/#post-428627
      # This is the only setting that works here. Other PHP versions must be added manually.
      --use-php=system \
      \
      # FIX [ERROR] Exception occured: ISPConfigOSException -> Command mount -o remount / 2>&1 && quotaoff -avug 2>&1 && quotacheck -avugm 2>&1 && quotaon -avug 2>&1 failed. (/ispconfig.ai.php:15)
      --no-quota \
      \
      # provided by the docker host
      --no-firewall \
      --no-ntp \
      \
      # optional:
      --debug \
      --use-ftp-ports=40110-40210 \
      --unattended-upgrades \
      # --unattended-upgrades=autoclean,reboot \
      # --use-nginx \
      # --use-amavis \
      # --use-unbound \
      # --use-certbot \
      # --no-web \
      # --no-mail \
      # --no-dns \
      # --no-local-dns \
      # --no-roundcube \
      # --roundcube \
      # --no-pma \
      # --no-mailman \
      ${OPTIONS_ISPCONFIG} \
  \
  # record ispconfig setup logfile (contains passwords!) and cleanup
  && mv /tmp/ispconfig-ai/var/log/setup-*.log /root/ispconfig-setup.log \
  && rm -rf /tmp/ispconfig* \
  && mv /usr/bin/hostname{.bak,}

ARG PORT_SSHD=2222
RUN echo "Port ${PORT_SSHD}" >> /etc/ssh/sshd_config

# Limit clamav memory usage
# https://betatim.github.io/posts/clamav-memory-usage/
# https://blog.clamav.net/2020/09/clamav-01030-released.html
RUN echo "ConcurrentDatabaseReload no" >> /etc/clamav/clamd.conf

# FIX /phpmyadmin 404 ; missing /etc/apache2/conf-*/phpmyadmin.conf
RUN dpkg-reconfigure phpmyadmin

# Manually register additional PHP version with ISPConfig
RUN /etc/init.d/mysql restart \
  && mysql \
    --defaults-file=/etc/mysql/debian.cnf \
    -e "INSERT IGNORE INTO dbispconfig.server_php \
      ( \
        sys_userid, \
        sys_groupid, \
        sys_perm_user, \
        sys_perm_group, \
        sys_perm_other, \
        server_id, \
        client_id, \
        name, \
        php_fastcgi_binary, \
        php_fastcgi_ini_dir, \
        php_fpm_init_script, \
        php_fpm_ini_dir, \
        php_fpm_pool_dir, \
        php_fpm_socket_dir, \
        active \
      ) VALUES \
      ( \
        1, \
        1, \
        'riud', \
        'riud', \
        '', \
        1, \
        0, \
        'PHP ${VERSION_PHP}', \
        '/usr/bin/php-cgi${VERSION_PHP}', \
        '/etc/php/${VERSION_PHP}/cgi', \
        '/etc/init.d/php${VERSION_PHP}-fpm', \
        '/etc/php/${VERSION_PHP}/fpm', \
        '/etc/php/${VERSION_PHP}/fpm/pool.d', \
        '', \
        'y' \
      );"

# Optionally install additional system packages
ARG PKGS=
RUN apt-get update \
  && apt-get install -y --no-install-recommends \
    ${PKGS} \
  && rm -rf /var/lib/apt/lists/*

# web, mail, DNS, panels
EXPOSE ${PORT_SSHD}
EXPOSE 20 21 22 80 443 40110-40210
EXPOSE 25 110 143 465 587 993 995
EXPOSE 53/udp
EXPOSE 8080 8081

CMD [ "/sbin/init" ]
