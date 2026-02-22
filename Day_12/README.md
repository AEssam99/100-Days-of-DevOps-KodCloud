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
Output:
```json
        <p>If you would like to let the administrators of this website know that you've seen this page instead of the page you expected, you should send them e-mail. In general, mail sent to the name "webmaster" and directed to the website's domain should reach the appropriate person.</p>
        <p>For example, if you experienced problems while visiting www.example.com, you should send e-mail to "webmaster@example.com".</p>
      </div>
      <div class="col-xl-6">
        <h2>If you are the website administrator:</h2>
        <p>You may now add content to the webroot directory. Note that until you do so, people visiting your website will see this page, and not your content.</p>
        <p>For systems using the Apache HTTP Server: You may now add content to the directory <code>/var/www/html/</code>. Note that until you do so, people visiting your website will see this page, and not your content. To prevent this page from ever being used, follow the instructions in the file <code>/etc/httpd/conf.d/welcome.conf</code>.</p>
        <p>For systems using NGINX: You should now put your content in a location of your choice and edit the <code>root</code> configuration directive in the <strong>nginx</strong> configuration file <code>/etc/nginx/nginx.conf</code>.</p>
        <p><a href="https://www.centos.org/"><img src="/icons/poweredby.png" alt="[ Powered by CentOS ]"></a> <img src="poweredby.png" alt="[ Powered by CentOS ]"></p>
      </div>
    </div>
    <hr>
    <div class="row">
      <div class="col">
        <h2 class="alert-heading">Important note!</h2>
        <p>The CentOS Project has nothing to do with this website or its content, it just provides the software that makes the website run.</p>
        <p>If you have issues with the content of this site, contact the owner of the domain, not the CentOS project. Unless you intended to visit CentOS.org, the CentOS Project does not have anything to do with this website, the content or the lack of it.</p>
        <p>For example, if this website is www.example.com, you would find the owner of the example.com domain at the following WHOIS server: <a href="http://www.internic.net/whois.html">http://www.internic.net/whois.html</a></p>
      </div>
    </div>
  </main>
  <footer class="container">
    <div>&#xA9; 2021 The CentOS Project | <a href="https://www.centos.org/legal/">Legal</a> | <a href="https://www.centos.org/legal/privacy/">Privacy</a></div>
  </footer>
</body>
</html>
```
It works now.
