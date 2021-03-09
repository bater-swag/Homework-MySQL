**1 task** \
locate my.cnf \
sudo nano /etc/mysql/my.cnf \
[client] \
user=root \
password=root123

**2 task** \
mysql -u root -p  
CREATE DATABASE example; \
USE example; \
CREATE TABLE users (id SERIAL PRIMARY KEY, name VARCHAR(255) COMMENT 'name'); \
exit;

**3_task** \
mysql -u root -p \
CREATE DATABASE sample; \
exit;

mysqldump -u root -p example > sample.sql \
mysql -u root -p sample < sample.sql

**4_task** \
mysqldump -u root -p --opt --where="1 limit 100" mysql help_keyword > first_100_rows_help_keyword.sql