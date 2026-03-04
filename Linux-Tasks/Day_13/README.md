# Day 13: IPtables Installation And Configuration
## Task
We have one of our websites up and running on our Nautilus infrastructure in Stratos DC. Our security team has raised a concern that right now Apache’s port i.e 5000 is open for all since there is no firewall installed on these hosts. 
So we have decided to add some security layer for these hosts and after discussions and recommendations we have come up with the following requirements: 
1. Install iptables and all its dependencies on each app host. 
2. Block incoming port 5000 on all apps for everyone except for LBR host. 
3. Make sure the rules remain, even after system reboot.

## Solution
`Note` We will perform the below tasks on stapp01,stapp02 and stapp03
### Install iptables-services
```sh
sudo dnf install -y iptables iptables-services
```
### Make sure firewalld service is disabled
```sh
sudo systemctl disable --now firewalld
```
### Enable and start iptables service
```sh
sudo systemctl enable --now iptables
```
Check:
```sh
systemctl status iptables --no-pager
```
### Add the rules (port 5000 only from LBR)
```sh
# Allow LBR to 5000
sudo iptables -I INPUT 1 -p tcp -s 172.16.238.14 --dport 5000 -j ACCEPT

# Block everyone else to 5000
sudo iptables -I INPUT 2 -p tcp --dport 5000 -j REJECT --reject-with icmp-port-unreachable
Verify:
```sh
sudo iptables -L INPUT -n --line-numbers
```
### SAVE permanently (this is the key part)
This is what the lab usually checks:
```sh
sudo service iptables save
```
Now confirm it wrote to the right file:
```sh
sudo grep -n "5000" /etc/sysconfig/iptables
```
You should see your ACCEPT/REJECT lines.
### Verifying
```sh
[loki@stlb01 ~]$ curl -I http://172.16.238.10:8089
```
`Output`
```sh
HTTP/1.1 403 Forbidden 
Date: Mon, 23 Feb 2026 22:34:04 GMT 
Server: Apache/2.4.62 (CentOS Stream) 
Last-Modified: Tue, 04 Jun 2024 22:57:12 GMT 
ETag: "296919-61a185ec88200" 
Accept-Ranges: bytes 
Content-Length: 2713881 
Content-Type: text/html; charset=UTF-8
```

