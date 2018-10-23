#!/bin/sh
set -e
set -x
/usr/sbin/apachectl -k start
ITOP_CONFIG=/var/www/html/itop/conf/production/config-itop.php
while ! test -f ${ITOP_CONFIG};
do
    sleep 5
done
sed -i "s#\('timezone' =>\).*#\1 'Asia/Shanghai',#g" ${ITOP_CONFIG}
sed -i "s/\('email_asynchronous' =>\).*/\1 true,/g" ${ITOP_CONFIG}
sed -i "s/\('email_default_sender_label' =>\).*/\1 'job',/g" ${ITOP_CONFIG}
sed -i "s/\('email_default_sender_address' =>\).*/\1 'xxx@xxx',/g" ${ITOP_CONFIG}
sed -i "s/\('email_transport' =>\).*/\1 'SMTP',/g" ${ITOP_CONFIG}
sed -i "/'email_transport' => '.*',/a \        'email_transport_smtp.port' => '25'," ${ITOP_CONFIG}
sed -i "/'email_transport' => '.*',/a \        'email_transport_smtp.password' => 'xxx'," ${ITOP_CONFIG}
sed -i "/'email_transport' => '.*',/a \        'email_transport_smtp.host' => 'xxx.xxx'," ${ITOP_CONFIG}
sed -i "/'email_transport' => '.*',/a \        'email_transport_smtp.username' => 'xxx@xxx'," ${ITOP_CONFIG}
# (crontab -l;echo "* * * * * echo '123' >> /var/log/itop-cron.log 2>＆1") | crontab
# echo "* * * * * root echo '123' >> /var/log/itop-cron.log 2>＆1" | tee -a /etc/crontab
echo "*/5 * * * * www-data /usr/bin/php /var/www/html/itop/webservices/cron.php --param_file=/root/cron.params >> /var/log/itop-cron.log 2>＆1" | tee -a /etc/crontab
touch /var/log/itop-cron.log
/usr/sbin/apachectl -k stop
/usr/bin/supervisord -c /root/supervisord.conf
# tail -f /var/log/messages
# tail -f /var/log/itop-cron.log