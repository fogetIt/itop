FROM centos:centos7
USER root
WORKDIR /root
RUN yum update -y && yum makecache fast
ADD iTop-2.5.0-3935.zip /root/iTop-2.5.0-3935.zip
# php72w need kernel 4.4.114
RUN yum install -y epel-release && \
    rpm -ivh http://rpms.famillecollet.com/enterprise/remi-release-7.rpm && \
    yum install -y \
        --enablerepo=remi \
        --enablerepo=remi-php56 \
            php \
            php-gd \
            php-mysqlnd \
            php-imap \
            php-soap \
            php-ldap \
            php-mbstring \
            php-mcrypt \
            php-pecl-zendopcache \
            php-domxml && \
    yum install -y graphviz unzip rsyslog crontabs supervisor && \
    unzip iTop-2.5.0-3935.zip -d /var/www/html/ && \
    mv /var/www/html/web /var/www/html/itop && \
    mkdir -p               /var/lib/php/session /var/www/html/itop/{conf,data,log,env-production} && \
    chown -R apache:apache /var/lib/php/session /var/www/html/itop && \
    sed -i '/session[ ]*required[ ]*pam_loginuid.so/d' /etc/pam.d/crond && \
    sed -i 's/^\$ModLoad imjournal.*/# &/g' /etc/rsyslog.conf && \
    sed -i 's/^\$IMJournalStateFile.*/# &/g' /etc/rsyslog.conf && \
    sed -i 's/^\(\$OmitLocalLogging\) on/\1 off/g' /etc/rsyslog.conf && \
    sed -i 's/^\$SystemLogSocketName.*/# &/g' /etc/rsyslog.d/listen.conf