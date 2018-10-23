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
echo "*/5 * * * * apache /usr/bin/php /var/www/html/itop/webservices/cron.php --param_file=/root/cron.params >> /var/log/itop-cron.log 2>＆1" | tee -a /etc/crontab
```