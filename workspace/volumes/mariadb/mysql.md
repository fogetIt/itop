```bash
wget http://repo.mysql.com/mysql57-community-release-el7-8.noarch.rpm
rpm -ivh mysql57-community-release-el7-8.noarch.rpm
yum install mysql-server
systemctl status mysqld
systemctl start mysqld
grep "password" /var/log/mysqld.log
mysql -u root -p
```

```sql
SET PASSWORD = PASSWORD('root密码');
ALTER USER 'root'@'localhost' PASSWORD EXPIRE NEVER;
GRANT ALL PRIVILEGES ON *.* TO root@"%" IDENTIFIED BY "root密码" WITH GRANT OPTION;
CREATE DATABASE itop;
GRANT ALL PRIVILEGES ON itop.* TO itop@"%" IDENTIFIED BY 'itop密码';
FLUSH PRIVILEGES;
```

```bash
vim /etc/my.cnf
: <<'COMMIT'
[client]
default-character-set=utf8

[mysqld]
character_set_server=utf8
innodb_buffer_pool_size = 512M
query_cache_size = 32M
query_cache_limit = 1M
COMMIT
systemctl restart mysqld
```

```sql
SHOW variables like '%character%';
-- SET PASSWORD FOR 'itop'@'localhost' = PASSWORD('itop密码');
SHOW table status from mysql like '%xxx%';
SHOW full columns from xxx;
```