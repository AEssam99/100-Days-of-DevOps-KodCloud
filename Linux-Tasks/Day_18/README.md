# Day 18: Configure LAMP server
## Task
xFusionCorp Industries is planning to host a WordPress website on their infra in Stratos Datacenter. 
They have already done infrastructure configuration—for example, on the storage server they already have a shared directory 
/vaw/www/html that is mounted on each app host under /var/www/html directory. 
Please perform the following steps to accomplish the task:

a. Install httpd, php and its dependencies on all app hosts.

b. Apache should serve on port 3000 within the apps.

c. Install/Configure MariaDB server on DB Server.

d. Create a database named kodekloud_db3 and create a database user named kodekloud_cap identified as password LQfKeWWxWD. 
Further make sure this newly created user is able to perform all operation on the database you created.

e. Finally you should be able to access the website on LBR link, by clicking on the App button on the top bar. 
You should see a message like App is able to connect to the database using user kodekloud_cap
## Solution
### Install httpd & php on app hosts
```sh
sudo yum install httpd php php-fpm php-mysqlnd -y
```
Start and enable httpd service
```
sudo systemctl enable --now httpd
```
### Configure port 3000 for apache
```sh
sudo vi /etc/httpd/conf/httpd.conf
```
change the line
```sh
Listen 80
```
To 
```sh
Listen 3000
```
### Check the firewall fo httpd port
If enabled
```sh
sudo firewall-cmd --permanent --add-port=3000/tcp
sudo firewall-cmd --reload
```
### Restart httpd service and verify
```
sudo systemctl restart httpd
```
To verify
```sh
sudo ss -tulnp | grep 3000
```
You should see the port is listening using httpd process
### Install/Configure MariaDB server on DB Server
```sh
sudo dnf install mariadb-server -y
```
Then enable and start the service
```sh
sudo systemctl enable --now mariadb
```
### Create new DB and DB user
Connect to MariaDB as root
```sh
sudo mysql
```
Then
```mysql
CREATE DATABASE kodekloud_db3;
CREATE USER 'kodekloud_cap'@'%' IDENTIFIED BY 'LQfKeWWxWD';
GRANT ALL PRIVILEGES ON kodekloud_db3.* TO 'kodekloud_cap'@'%';
FLUSH PRIVILEGES;
```
To verfify
```mysql
SHOW DATABASES;
```
`Output`
```mysql
+--------------------+ 
| Database | 
+--------------------+ 
| information_schema | 
| kodekloud_db3 | 
| mysql | 
| performance_schema | 
+--------------------+ 
4 rows in set (0.003 sec)
```
```mysql
SELECT user, host FROM mysql.user;
```
`Output`
```mysql
+---------------+-----------+
| User          | Host      |
+---------------+-----------+
| kodekloud_cap | %         |
+---------------+-----------+
```
### Check the firewall fo mariadb
If enabled
```sh
sudo firewall-cmd --permanent --add-service=mysql
sudo firewall-cmd --reload
```
### Check to access the DB via LBR server
```sh
http://172.16.238.14
```
Or using the App button
You should see
```html
App is able to connect to the database using user kodekloud_cap
```



