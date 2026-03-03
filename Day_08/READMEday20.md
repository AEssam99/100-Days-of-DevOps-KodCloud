# Day 20: Configure Nginx + PHP-FPM Using Unix Sock
## Task
The Nautilus application development team is planning to launch a new PHP-based application, which they want to deploy on Nautilus infra in Stratos DC. 
The development team had a meeting with the production support team and they have shared some requirements regarding the infrastructure. 
Below are the requirements they shared:

a. Install nginx on app server 3 , configure it to use port 8098 and its document root should be /var/www/html.

b. Install php-fpm version 8.2 on app server 3, it must use the unix socket /var/run/php-fpm/default.sock (create the parent directories if don't exist).

c. Configure php-fpm and nginx to work together.

d. Once configured correctly, you can test the website using curl http://stapp03:8098/index.php command from jump host.

NOTE: We have copied two files, index.php and info.php, under /var/www/html as part of the PHP-based application setup. Please do not modify these files.
## Solution
### Instal nginx on app server 3
```sh
sudo dnf install nginx -y
```
Start and enable the nginx service
```sh
sudo systemctl enable --now nginx
```
### Configure nginx
```sh
sudo vi /etc/nginx/nginx.conf
```
change the line 
```sh
Listen 80
```
To
```sh
Listen 8098
```
Now the nginx port is 8098
Then change the document root as followed
```sh
root /var/www/html
```
Save and exit
Restart nginx service
```sh
sudo systemctl restart nginx
```
###  Allow Port 8098 (If Firewall Enabled)
```sh
sudo firewall-cmd --permanent --add-port=8098/tcp
sudo firewall-cmd --reload
```
### Install php-fpm version 8.2
```sh
sudo dnf module reset php -y
sudo dnf module enable php:8.2 -y
sudo dnf install -y php php-fpm
```
Enable and start php-fpm service
```sh
sudo systemctl enable --now php-fpm
```
### Configure the php-fpm and nginx
Configure the php-fpm
```sh
sudo vi /etc/php-fpm.d/www.conf
```
Modify the following lines
```sh
user = nginx
group = nginx

listen = /var/run/php-fpm/default.sock
listen.owner = nginx
listen.group = nginx
listen.mode = 0660
```
Save and exit
Then add configuration for the nginx.conf
```sh
sudo vi /etc/nginx/nginx.conf
```
Add the followng to server section
```sh
server {
    listen 8098;
    server_name stapp03;

    root /var/www/html;
    index index.php index.html;

    location / {
        try_files $uri $uri/ =404;
    }

    location ~ \.php$ {
        include fastcgi_params;
        fastcgi_pass unix:/var/run/php-fpm/default.sock;
        fastcgi_index index.php;
        fastcgi_param SCRIPT_FILENAME $document_root$fastcgi_script_name;
    }
}
```
make sure the following lines are commented
```sh
# include /etc/nginx/conf.d/*.conf;
# include /etc/nginx/default.d/*.conf;
```
### Restart all php-fpm and nginx services
```sh
sudo systemctl restart nginx
sudo systemctl restart php-fpm
```
### Test from the jump host
```sh
curl http://stapp03:8098/index.php
```
``Output``
```sh
Welcome to xFusionCorp Industries!
```



