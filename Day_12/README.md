# Day 12: Linux Network Services
## Task
Our monitoring tool has reported an issue in Stratos Datacenter. One of our app servers has an issue, as its Apache service is not reachable on port 6100 (which is the Apache port). 
The service itself could be down, the firewall could be at fault, or something else could be causing the issue.

Use tools like telnet, netstat, etc. to find and fix the issue. Also make sure Apache is reachable from the jump host without compromising any security settings.

Once fixed, you can test the same using command curl http://stapp01:6100 command from jump host.

Note: Please do not try to alter the existing index.html code, as it will lead to task failure.

## Solution
### Testing access the web page from jump host
```sh
curl http://stapp01:6100
```
Output:
```sh
curl: (7) Failed to connect to stapp01 port 6100: No route to host
```
### Trying to connect stapp01 via ssh from jump host
```sh
ssh tony@172.16.238.10
```
So it's not a connection issue
### Checking httpd Service status
```sh
sudo systemctl status httpd
```
- We will find it's inactive.
- Let's check the logs
```sh
sudo journalctl -xeu httpd.service
```
Output:
```sh
Feb 22 08:57:20 stapp01.stratos.xfusioncorp.com systemd[1]: httpd.service: Got notification message f rom PID 2020 (RELOADING=1, STATUS=Reading configuration...) 
Feb 22 08:57:20 stapp01.stratos.xfusioncorp.com httpd[2020]: (98)Address already in use: AH00072: make_sock: could not bind t o address 0.0.0.0:6100 
Feb 22 08:57:20 stapp01.stratos.xfusioncorp.com httpd[2020]: no listening sockets available, shutting down 
Feb 22 08:57:20 stapp01.stratos.xfusioncorp.com httpd[2020]: AH00015: Unable to open logs 
Feb 22 08:57:20 stapp01.stratos.xfusioncorp.com systemd[1]: httpd.service: Child 2020 belongs to http d.service. 
Feb 22 08:57:20 stapp01.stratos.xfusioncorp.com systemd[1]: httpd.service: Main process exited, code=....
```
The line 
```sh
Feb 22 08:57:20 stapp01.stratos.xfusioncorp.com httpd[2020]: (98)Address already in use: AH00072: make_sock: could not bind t o address 0.0.0.0:6100
```
means there is another service which is using the same port 6100.
### Checking who is using port 6100
```sh
sudo netstat -tulnp | grep 6100
```
or 
```sh
sudo ss -tulnp | grep 6100
```
The output:
```sh
tcp 0 0 127.0.0.1:6100 0.0.0.0:* LISTEN 493/sendmail: accept
```
So Sendmail service is using the same port
### Stop sendmail (Safe Fix) 
```sh
sudo systemctl stop sendmail
sudo systemctl disable sendmail
```
Then enable and start httpd service again
```sh
sudo systemctl enable --now httpd
```
Then check the port 6100 again
```sh
sudo netstat -tulnp | grep 6100
```
The output:
```sh
tcp 0 0 127.0.0.1:6100 0.0.0.0:* LISTEN 493/httpd: accept
```
**Note:** In production don't stop sendmail service directly, Change the listening port of httpd or sendmail service.
### Verifying 
Test from jumphost 
```sh
curl http://stapp01:6100
```
Output:
```sh
curl: (7) Failed to connect to stapp01 port 6100: No route to host
```
So there is another issue which stop the service from the jump host side.
### Check firewall
```sh
sudo iptables -L -n 
```
Output:
```sh
Chain INPUT (policy ACCEPT) 
target prot opt source destination 
ACCEPT all -- 0.0.0.0/0 0.0.0.0/0 state RELATED,ESTABLISHED 
ACCEPT icmp -- 0.0.0.0/0 0.0.0.0/0 ACCEPT all -- 0.0.0.0/0 0.0.0.0/0 
ACCEPT tcp -- 0.0.0.0/0 0.0.0.0/0 state NEW tcp dpt:22 
REJECT all -- 0.0.0.0/0 0.0.0.0/0 reject-with icmp-host-prohibited 
Chain FORWARD (policy ACCEPT) 
target prot opt source destination 
REJECT all -- 0.0.0.0/0 0.0.0.0/0 reject-with icmp-host-prohibited 
```
The 1st line:
```sh
ACCEPT all -- 0.0.0.0/0 0.0.0.0/0 state RELATED,ESTABLISHED 
```
- That rule doesn’t allow new connections — it only allows traffic that’s already part of an existing connection.
- We have to make the firewall accept the new connections
```sh
sudo iptables -I INPUT 1 -p tcp --dport 6100 -j ACCEPT
```
Now let's check the firewall rules again:
```sh 
sudo iptables -L -n 
```
Output:
```sh
Chain INPUT (policy ACCEPT) 
target prot opt source destination
ACCEPT tcp -- 0.0.0.0/0 0.0.0.0/0 tcp dpt:6100 
ACCEPT all -- 0.0.0.0/0 0.0.0.0/0 state RELATED,ESTABLISHED 
ACCEPT icmp -- 0.0.0.0/0 0.0.0.0/0 ACCEPT all -- 0.0.0.0/0 0.0.0.0/0 
ACCEPT tcp -- 0.0.0.0/0 0.0.0.0/0 state NEW tcp dpt:22 
REJECT all -- 0.0.0.0/0 0.0.0.0/0 reject-with icmp-host-prohibited 
Chain FORWARD (policy ACCEPT) 
target prot opt source destination 
REJECT all -- 0.0.0.0/0 0.0.0.0/0 reject-with icmp-host-prohibited 
```
### Let's Check the connection from the jump host again
```sh
curl http://stapp01:6100
```
It works now.
