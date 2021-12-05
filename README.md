# LOCKSS network dashboard installation 

![Dashboard screenshot](https://anthonyleroy.github.io/lockss-dashboard/lockss_network_dashboard.jpg)

First, you need to configure plnmonitor:

```
./config.sh
```


This script allows the administrator to:
- set the URL for their own LOCKSS network props server (lockss.xml) 
- define the credentials to get status information for each box
- provide additional information for each box (geographical coordinates, institution, administrator,...)


Edit the docker-compose.yml file and replace "yourdomain.org" with your own server hostname on the following lines:

```
GF_SERVER_DOMAIN: yourdomain.org
GF_SERVER_ROOT_URL: https://yourdomain.org
- "traefik.http.routers.grafana.rule=Host(`yourdomain.org`)"
```

Edit your email address for Lets Encrypt certificate : 

```
- "--certificatesresolvers.letsencrypt.acme.email=youremail@yourdomain.org"
```

Then, to bring up the dashboard, use:

```
./start.sh
```

The plnmonitor webapp is then available at the following URL:
https://yourdomain.org/

## Requirements

### Setting a Debug User Access

On each  box in your LOCKSS network, a user should be defined to get status information from the boxes.

For obvious safety reasons, a debug user should be specifically defined for this purpose. 
In order to do that: 

- connect to the LOCKSS UI of your LOCKSS box as an administrator
- select User Accounts  on the right side menu
- enter a Username (e.g. debug) and hit the "Create User" button
- enter a password and an email address
- tick only the "View debug info" checkbox
- hit the "Add User" button

### Firewall and UI Access Control Settings

Each LOCKSS box firewall should authorize access to the user interface (typically TCP input port 8081)) for the IP address of 
the machine running plnmonitor.
This IP should also be authorized in the "Admin Access Control" menu of your LOCKSS box in the "Allow Access" list. 

### Loki (optional) 

Loki is a log aggregation system integrated with the LOCKSS dashboard to collect the log files from all LOCKSS boxes in the ne
twork in a centralized access point. Various log files are collected and consolidated to help users analyze and identify probl
ems..

Promtail agents running on the boxes must be configured to collect the following files: 

- /var/log/messages
- /var/log/lockss/stdout
- /var/log/lockss/daemon

The machine running the dashboard should authorize access to input port 3100/TCP for all LOCKSS boxes IP addresses in the netw
ork.

### Prometheus (optional)

Prometheus is an advanced monitoring and alert system integrated with the dashboard to collect metrics from all LOCKSS boxes i
n the network. It provides in-depth observability of the software and infratructure stack.  

Node exporter agents running on the boxes must be configured to collect the following metrics:

```
--collector.systemd 
--collector.processes
```

LOCKSS boxes should authorize access to input port 9100/TCP for the machine running the dashboard.

## Known issue 

### SOAP access to LOCKSS boxes with SSL enabled
While the Daemon Status web service is directly accessible with basic authentication, when SSL is switched on, the authenticat
ion is done with a form-based login webpage and prevents using the web service. Given that the access control mechanism will b
e considerably improved in LAAWS, it seemed more useful to focus on the other plnmonitor features.
