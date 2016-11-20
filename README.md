#### carbon-bridge

Execute metrics collection scripts from a statically defined directory at a configured interval, and forward the metrics to carbon-cache.


##### sample configuation:

```
---
debug: true
logging: STDOUT
collect:
  looptime: 3
  plugins: '/home/shafez/.config/carbon-bridge/plugins'
carbon:
  server_ip: 192.0.2.18
  server_port: 2003
  tx_protocol: udp
```

##### configuration explanation:

```
debug: activate/deactivate system debug
logging: define the target of log ('STDOUT' for console logging)
collect:
  looptime: how many seconds to sleep between executions
  plugins: directory of metrics collection plugins 
carbon:
  server_ip: carbon-cache server ip address
  server_port: carbon-cache server port
  tx_protocol: carbon-cache communication protocols (tcp/udp)
```
