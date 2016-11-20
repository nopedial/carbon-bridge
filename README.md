#### carbon-bridge

##### sample configuation:

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

