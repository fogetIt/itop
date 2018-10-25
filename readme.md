##### virtualbox
```bash
ADDR="https://github.com/CommanderK5/packer-centos-template/releases/download/0.7.2/vagrant-centos-7.2.box"
vagrant box add centos/7 ${ADDR}
vagrant init centos/7
vagrant up
```

##### [邮件测试](http:xxx/itop/setup/email.test.php)

##### run.sh
```bash
#!/bin/sh
set -e
set -x
chown -R apache:apache /var/lib/php/session /var/www/html/itop
/usr/sbin/apachectl -k start
ITOP_CONFIG=/var/www/html/itop/conf/production/config-itop.php
while ! test -f ${ITOP_CONFIG};
do
    sleep 5
done
sed -i "s#\('timezone' =>\).*#\1 'Asia/Shanghai',#g" ${ITOP_CONFIG}
sed -i "s/\('email_asynchronous' =>\).*/\1 true,/g" ${ITOP_CONFIG}
sed -i "s/\('email_default_sender_label' =>\).*/\1 'job',/g" ${ITOP_CONFIG}
sed -i "s/\('email_default_sender_address' =>\).*/\1 'xxx@xxx.xxx',/g" ${ITOP_CONFIG}
sed -i "s/\('app_root_url' =>\).*/\1 'http://xxxx:8080/itop/',/g" ${ITOP_CONFIG}
sed -i "s/\('email_transport' =>\).*/\1 'SMTP',/g" ${ITOP_CONFIG}
sed -i "/'email_transport' => '.*',/a \        'email_transport_smtp.port' => 'xxx'," ${ITOP_CONFIG}
sed -i "/'email_transport' => '.*',/a \        'email_transport_smtp.password' => 'xxx'," ${ITOP_CONFIG}
sed -i "/'email_transport' => '.*',/a \        'email_transport_smtp.host' => 'xxx.xxx.xxx'," ${ITOP_CONFIG}
sed -i "/'email_transport' => '.*',/a \        'email_transport_smtp.username' => 'xxx@xxx.xxx'," ${ITOP_CONFIG}
# (crontab -l;echo "* * * * * echo '123' >> /var/log/itop-cron.log 2>＆1") | crontab
echo "*/5 * * * * root /usr/bin/php /var/www/html/itop/webservices/cron.php --param_file=/root/cron.params >> /var/log/itop-cron.log 2>＆1" | tee -a /etc/crontab
touch /var/log/itop-cron.log
/usr/sbin/apachectl -k stop
/usr/bin/supervisord -c /root/supervisord.conf
# tail -f /var/log/messages
# tail -f /var/log/itop-cron.lo
```