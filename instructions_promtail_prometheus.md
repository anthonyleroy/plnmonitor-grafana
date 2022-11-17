Installing Promtail Loki agent on your LOCKSS box
----------------------

Connect to your LOCKSS box with ssh and download the Promtail Loki agent binary then unzip the file:

```
# wget https://github.com/grafana/loki/releases/download/v2.3.0/promtail-linux-amd64.zip
# unzip promtail-linux-amd64.zip
```

Copy the Promtail binary to your /usr/local/bin path and make it executable
```
# sudo cp promtail-linux-amd64 /usr/local/bin/promtail
# sudo chmod a+x /usr/local/bin/promtail
```

Create a file named /etc/promtail-local-config.yaml with the following content and replace the 3 occurrences of [institution] by your institution shortname (LU, UCLouvain, UGent, ULB, UMontreal, UniBi or UNIGE).

```
server:
  http_listen_port: 9080
  grpc_listen_port: 0

positions:
  filename: /tmp/positions.yaml

clients:
  - url: http://164.15.1.89:3100/loki/api/v1/push

scrape_configs:
- job_name: system
  static_configs:
  - targets:
      - localhost
    labels:
      job: system
      host: [institution]
      __path__: "/var/log/messages"


- job_name: lockss
  static_configs:
  - targets:
      - localhost
    labels:
      job: lockss
      host: [institution]
      __path__: "/var/log/lockss/daemon"

- job_name: lockss_std
  static_configs:
  - targets:
      - localhost
    labels:
      job: lockss
      host: [institution]
      __path__: "/var/log/lockss/stdout"
```

Creating a promtail service
------------------------

Instructions depend on whether you are still using **_CentOS6_** or **_CentOS7_**.

1. For **_CentOS6_**

Create a promtail service by creating a file named /etc/init.d/promtail  with the following content:

```
#
# promtail Loki service (monitoring)
#
# chkconfig: 2345 08 92
# description: Starts and stops the Loki promtail service 


OPTIONS="-config.file=/etc/promtail-local-config.yaml"
RETVAL=0
PROG="promtail"
EXEC="/usr/local/bin/promtail"
LOCKFILE="/var/lock/subsys/$PROG"
LOGFILE=/var/log/promtail.log
ErrLOGFILE=/var/log/promtail_error.log

# Source function library.
if [ -f /etc/rc.d/init.d/functions ]; then
  . /etc/rc.d/init.d/functions
else
  echo "/etc/rc.d/init.d/functions is not exists"
  exit 0
fi

start() {
  if [ -f $LOCKFILE ]
  then
    echo "$PROG is already running!"
  else
    echo -n "Starting $PROG: "
    nohup $EXEC $OPTIONS > $LOGFILE 2> $ErrLOGFILE &
    RETVAL=$?
    [ $RETVAL -eq 0 ] && touch $LOCKFILE && success || failure
    echo
    return $RETVAL
  fi
}

stop() {
  echo -n "Stopping $PROG: "
  killproc $EXEC
  RETVAL=$?
  [ $RETVAL -eq 0 ] && rm -r $LOCKFILE && success || failure
  echo
}

restart ()
{
  stop
  sleep 1
  start
}

case "$1" in
  start)
    start
    ;;
  stop)
    stop
    ;;
  status)
    status $PROG
    ;;
  restart)
    restart
    ;;
  *)
    echo "Usage: $0 {start|stop|restart|status}"
    exit 1
esac
exit $RETVAL
```

Start the promtail service:
```
# sudo service promtail start
```

Enable promtail at start:
```
# sudo chkconfig promtail on
```

Open output port 3100/tcp to the dashboard server (164.15.1.89):
```
# sudo iptables -I OUTPUT 2 -o eth0 -p tcp -d 164.15.1.89 --dport 3100 -j ACCEPT
```

Then, apply the rule:
```
$ sudo service iptables start 
```

Finally, save the iptables config permanently:
```
$ sudo service iptables save 
```
(this will write the current rules in file /etc/sysconfig/iptables).

2. For **_CentOS7_**:

Create a specific user for promtail and add it to the admin group
```
# sudo useradd --system promtail
# sudo usermod -a -G adm promtail
```

Create a file /etc/systemd/system/promtail.service with the following content:

```
[Unit]
Description=Promtail service
After=network.target

[Service]
Type=simple
User=promtail
ExecStart=/usr/local/bin/promtail -config.file=/etc/promtail-local-config.yaml

[Install]
WantedBy=multi-user.target
```

Start the service 
```
# sudo service promtail start
```

Output port 3100/tcp to the dashboard server (164.15.1.89) should be enable by default on CentOS7.

Installing Prometheus agent (Node exporter)
===========================

Instructions depend on whether you are still using **_CentOS6_** or **_CentOS7_**.

1. For _**CentOS6**_:
--------------

Download the node exporter agent binary and untar it :
```
# curl -s https://api.github.com/repos/prometheus/node_exporter/releases/latest | grep browser_download_url | grep linux-amd64 |  cut -d '"' -f 4 | wget -qi -
# tar xvf node_exporter-*linux-amd64.tar.gz
```

Move the binary to /usr/local/bin:
```
# sudo mv ./node_exporter-1.3.0.linux-amd64/node_exporter /usr/local/bin/
```
Create a parameter file for node exporter named /etc/sysconfig/node_exporter with the following content:

```
--collector.cpu --collector.diskstats --collector.processes --collector.filesystem --collector.loadavg --collector.meminfo --collector.filefd --collector.netdev --collector.stat --collector.netstat --collector.systemd --collector.uname --collector.vmstat --collector.time --collector.mdadm --collector.xfs --collector.zfs --collector.tcpstat --collector.bonding --collector.hwmon --collector.arp --web.listen-address=:9100
```                                                             

Create a file named /etc/init.d/node_exporter with the following content :
```
#!/bin/bash

#
# node_exporter	Prometheus node exporter service (monitoring)
#
# chkconfig: 2345 08 92
# description: Starts and stops the Prometheus node exporter service 


OPTIONS=`cat /etc/sysconfig/node_exporter`
RETVAL=0
PROG="node_exporter"
EXEC="/usr/local/bin/node_exporter"
LOCKFILE="/var/lock/subsys/$PROG"
LOGFILE=/var/log/node_exporter.log
ErrLOGFILE=/var/log/node_exporter_error.log

# Source function library.
if [ -f /etc/rc.d/init.d/functions ]; then
  . /etc/rc.d/init.d/functions
else
  echo "/etc/rc.d/init.d/functions is not exists"
  exit 0
fi

start() {
  if [ -f $LOCKFILE ]
  then
    echo "$PROG is already running!"
  else
    echo -n "Starting $PROG: "
    nohup $EXEC $OPTIONS > $LOGFILE 2> $ErrLOGFILE &
    RETVAL=$?
    [ $RETVAL -eq 0 ] && touch $LOCKFILE && success || failure
    echo
    return $RETVAL
  fi
}

stop() {
  echo -n "Stopping $PROG: "
  killproc $EXEC
  RETVAL=$?
  [ $RETVAL -eq 0 ] && rm -r $LOCKFILE && success || failure
  echo
}

restart ()
{
  stop
  sleep 1
  start
}

case "$1" in
  start)
    start
    ;;
  stop)
    stop
    ;;
  status)
    status $PROG
    ;;
  restart)
    restart
    ;;
  *)
    echo "Usage: $0 {start|stop|restart|status}"
    exit 1
esac
exit $RETVAL
```

Start and enable the node_exporter service:
```
# sudo /etc/init.d/node_exporter start
# sudo chkconfig node_exporter on
```
Open input port 9100/tcp for the dashboard server (164.15.1.89):
```
# iptables -I INPUT 2 -i eth0 -p tcp -s 164.15.1.89 --dport 9100 -j ACCEPT
```

2. For _**CentOS7**_:
--------------

Create a file named /etc/yum.repos.d/prometheus.repo:
```
[prometheus]
name=prometheus
baseurl=https://packagecloud.io/prometheus-rpm/release/el/$releasever/$basearch
repo_gpgcheck=1
enabled=1
gpgkey=https://packagecloud.io/prometheus-rpm/release/gpgkey
       https://raw.githubusercontent.com/lest/prometheus-rpm/master/RPM-GPG-KEY-prometheus-rpm
gpgcheck=1
metadata_expire=300
```

Install the node exporter agent:
```
# sudo yum install node_exporter
```

Create a parameter file for node exporter named /etc/sysconfig/ with the following content:

```
--collector.cpu --collector.diskstats --collector.processes --collector.filesystem --collector.loadavg --collector.meminfo --collector.filefd --collector.netdev --collector.stat --collector.netstat --collector.systemd --collector.uname --collector.vmstat --collector.time --collector.mdadm --collector.xfs --collector.zfs --collector.tcpstat --collector.bonding --collector.hwmon --collector.arp --web.listen-address=:9100
```                                                             

Start and enable the node_exporter service:
```
# sudo systemctl enable node_exporter.service
# sudo systemctl start node_exporter.service
```
Open input port 9100/tcp for the dashboard server only (164.15.1.89):
```
# sudo firewall-cmd --permanent --zone=public --add-rich-rule=' rule family="ipv4" source address="164.15.1.89" port protocol="tcp" port="9100" accept'
# sudo firewall-cmd --reload
```
Please make sure that port 9100/tcp is not blocked by the perimeter firewall of your institution.
