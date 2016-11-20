#### carbon-bridge

carbon-bridge forwards the metrics it collects from user-defined scripts to carbon-cache servers.

#### configuation:

```
---
debug: true
logging: STDOUT
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

#### add a new scripts

1. create a script (language does NOT matter)
2. make the script executable
3. move the script to the 'plugins' directory (example: /home/shafez/.config/carbon-bridge/plugins)

#### script output

the scripts' output must be formatted as follows: metric.name.inbound metric.value

example:

```
shafez@testbox:~$ ./.config/carbon-bridge/plugins/test.rb 
hello.this.is.a.metric3 4.5
shafez@testbox:~$
```

##### NOTE: UTC timestamps are added automatically from carbon-bridge to every metric

#### carbon-cache

carbon-bridge can be configured to send metrics to several carbon-cache servers at the same time, using either udp or tcp
