# Day 19: Install and Configure Web Application
## Task
xFusionCorp Industries is planning to host two static websites on their infra in Stratos Datacenter. 
The development of these websites is still in-progress, but we want to get the servers ready. 
Please perform the following steps to accomplish the task:

a. Install httpd package and dependencies on app server 1.

b. Apache should serve on port 5001.

c. There are two website's backups /home/thor/beta and /home/thor/demo on jump_host. 
Set them up on Apache in a way that beta should work on the link http://localhost:5001/beta/ and demo should work on link http://localhost:5001/demo/ 
on the mentioned app server.

d. Once configured you should be able to access the website using curl command on the respective app server, i.e curl http://localhost:5001/beta/ and 
curl http://localhost:5001/demo/

## Solution
### Configure and install httpd on app server 1
```sh
sudo dnf install httpd -y
```
Enable and start the service
```sh
sudo sustemctl enable --now httpd
```
### Change the apache port
```sh
sudo vi /etc/httpd/conf/httpd.conf
```
and change the following line
```sh
Listen 80
```
to
```sh
Listen 5001
```
Allow ports via firewall (If enabled)
```sh
sudo firewall-cmd --permanent --add-port=5001/tcp
sudo firewall-cmd --reload
```
Restart the httpd service
```sh
sudo sustemctl restart httpd
```
### Copy the files from jump host to app server
```sh
scp -r thor@jump_host:/home/thor/beta /var/www/html/
scp -r thor@jump_host:/home/thor/demo /var/www/html/
```
change the owner to apache
```sh
sudo chown -R apache:apache /var/www/html/beta
sudo chown -R apache:apache /var/www/html/demo
```
### Set alias for the 2 static websites
```sh
sudo vi /etc/httpd/conf/httpd.conf
```
insert the following alias
```sh
Alias /beta /var/www/html/beta
Alias /demo /var/www/html/demo

<Directory /var/www/html/beta>
    Require all granted
</Directory>

<Directory /var/www/html/demo>
    Require all granted
</Directory>
```
Restart the httpd service
```sh
sudo sustemctl restart httpd
```
### Testing
```sh
curl -I http://localhost:5001/beta
curl -I http://localhost:5001/demo
```
`Output`
```sh
HTTP/1.1 200 OK
Date: Mon, 02 Mar 2026 09:16:44 GMT
Server: Apache/2.4.62 (CentOS Stream)
Last-Modified: Mon, 02 Mar 2026 09:08:20 GMT
ETag: "75-64c06eda79978"
Accept-Ranges: bytes
Content-Length: 117
Content-Type: text/html; charset=UTF-8
```
