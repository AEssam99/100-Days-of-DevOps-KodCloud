# Day 11: Install and Configure Tomcat Server

## Task 
The Nautilus application development team recently finished the beta version of one of their Java-based applications, which they are planning to deploy on one of the app servers in Stratos DC. 
After an internal team meeting, they have decided to use the tomcat application server. 
Based on the requirements mentioned below complete the task: 
a. Install tomcat server on App Server 1. 
b. Configure it to run on port 6400. 
c. There is a ROOT.war file on Jump host at location /tmp. 
Deploy it on this tomcat server and make sure the webpage works directly on base URL i.e curl http://stapp01:6400

## Solution
### What is Tomcat server?

Tomcat is a server that runs Java web apps (like .war files) and makes them accessible through a browser.

Tomcat implements:
- Java Servlet

- JSP (JavaServer Pages)

- WebSocket

- Basic HTTP server functionality

- So when you deploy a file like:
```sh
ROOT.war
```
Tomcat:

- Extracts it

- Runs the Java code

- Serves it over HTTP (like http://server:8080)

### Install Tomcat on App Server 1
```sh
sudo yum install -y tomcat tomcat-webapps tomcat-admin-webapps
```
### Enable & Start Tomcat service
```sh
sudo systemctl enable --now tomcat
```
### Change Tomcat port to 6400
Tomcat listens via the HTTP Connector in server.xml
```sh 
sudo vi /etc/tomcat/server.xml
```
Find the connector line like:
```xml
<Connector port="8080" protocol="HTTP/1.1"
```
Change 8080 → 6400:
```xml
<Connector port="6400" protocol="HTTP/1.1"
```
Then Restart again:
```sh
sudo systemctl restart tomcat
```
Confirm it’s listening:
```sh
sudo ss -lntp | grep 6400
```

### Copy and deploy ROOT.war from Jump host
Back on Jump host, copy the WAR to App Server 1.
```sh
scp /tmp/ROOT.war tony@stapp01:/tmp/ROOT.war
```
Now on stapp01, move it into Tomcat webapps as ROOT.war (this makes it serve from / base URL).
```sh
sudo cp /tmp/ROOT.war /var/lib/tomcat/webapps/ROOT.war
sudo chown tomcat:tomcat /var/lib/tomcat/webapps/ROOT.war
```
Then Restart again:
```sh
sudo systemctl restart tomcat
```
### Validate the app on base URL

From Jump host:
```sh
curl -I http://stapp01:6400
curl http://stapp01:6400
```
If it doesn’t come up:

ensure ROOT.war exists in the correct webapps folder

remove an old deployed ROOT directory and redeploy:

```sh
sudo rm -rf /var/lib/tomcat/webapps/ROOT
sudo systemctl restart tomcat
```

