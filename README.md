### carbon-bridge

carbon-bridge is a light-weight ruby daemon that periodically collects metrics from user-defined scripts and sends them to one or more carbon servers

### install

```
shafez@ns:~$ git clone https://github.com/nopedial/carbon-bridge
Cloning into 'carbon-bridge'...
remote: Counting objects: 92, done.
remote: Compressing objects: 100% (68/68), done.
remote: Total 92 (delta 36), reused 76 (delta 20), pack-reused 0
Unpacking objects: 100% (92/92), done.
Checking connectivity... done.
shafez@ns:~$ cd carbon-bridge/
shafez@ns:~/carbon-bridge$ bundle install
Resolving dependencies...
Using asetus 0.3.0
Using logger 1.2.8

[ ... ]
Your bundle is complete!
Use `bundle show [gemname]` to see where a bundled gem is installed.
shafez@ns:~/carbon-bridge$ rake install
  Successfully built RubyGem
  Name: carbon-bridge
  Version: 0.0.4
  File: carbon-bridge-0.0.4.gem
Successfully installed carbon-bridge-0.0.4
1 gem installed
shafez@ns:~/carbon-bridge$ cd
shafez@ns:~$ carbon-bridge
+ base configuration built at: ~/.config/carbon-bridge/config
shafez@ns:~$
```

### configuration

```
---
debug: true
logging: 'STDOUT'
pidfile: '/home/shafez/.config/carbon-bridge/pid.txt'
localhostname: server.example.com
collect:
  looptime: 300
  plugins: '/home/shafez/.config/carbon-bridge/plugins'
carbon:
  server_ip: 
  - 192.0.2.18
  - 192.0.2.19
  - 192.0.2.20
  server_port: 2003
  tx_protocol: udp
```

#### NOTE - to run the daemon in background set 'logging' to something different than 'STDOUT'

### add a script

1. create a new script (language does NOT matter)
2. make sure the script is executable
3. move the script to the 'plugins' directory (e.g.: /home/shafez/.config/carbon-bridge/plugins)

#### script output

scripts must return 'metric name / metric value' pairs as in the example below:

```
shafez@ns:~$ ./.config/carbon-bridge/plugins/example.rb 
system-metrics.uptime 77
shafez@ns:~$
```

#### timestamps

timestamps (epoch) can be passed as an optional value from the user-defined scripts:

```
shafez@ns:~$ ./.config/carbon-bridge/plugins/example.rb
system-metrics.uptime 77 1483399928
shafez@ns:~$
```

carbon-bridge will add a local timestamp if unable to retrieve one from the scripts output
