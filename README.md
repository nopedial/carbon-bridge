### carbon-bridge

carbon-bridge is a light-weight ruby daemon that periodically collects metrics from user-defined scripts and sends them to a set of carbon-cache servers

### configuration

```
---
debug: true
logging: STDOUT
pidfile: '/home/shafez/.config/carbon-bridge/pid.txt'
collect:
  looptime: 3
  plugins: '/home/shafez/.config/carbon-bridge/plugins'
carbon:
  server_ip: 
  - 192.0.2.18
  - 192.0.2.19
  - 192.0.2.20
  server_port: 2003
  tx_protocol: udp
```

### add a script

1. create a new script (language does NOT matter)
2. make sure the script is executable
3. move the script to the 'plugins' directory (e.g.: /home/shafez/.config/carbon-bridge/plugins)

#### script output

scripts must return 'metric name / metric value' pairs as in the example below:

```
shafez@ms:~$ ./.config/carbon-bridge/plugins/example.rb 
system-metrics.uptime 77
shafez@ms:~$
```

#### NOTE - carbon-bridge automatically adds timestamps before sending the metrics to the carbon-cache server
