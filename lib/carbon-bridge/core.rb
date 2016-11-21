module CarbonBridge

  if File.exists? '/etc/carbon-bridge/config'
    Cfg  				= Asetus.cfg name: 'carbon-bridge'
  else
    CFG = Asetus.new :name=>'carbon-bridge', :load=>false
    CFG.default.debug 			= true
    CFG.default.logging			= 'STDOUT'
    CFG.default.pidfile			= '~/.config/carbon-bridge/pid.txt'
    CFG.default.collect.looptime 	= 300
    CFG.default.collect.plugins		= '~/.config/carbon-bridge/plugins'
    CFG.default.carbon.server_ip	= [ '127.0.0.1' ]
    CFG.default.carbon.server_port	= 2003
    CFG.default.carbon.tx_protocol	= 'udp'
    CFG.load
    if CFG.create
      CFG.save
      puts '+ base configuration built at: ~/.config/carbon-bridge/config'
      exit 0
    else
      Cfg = CFG.cfg
      if Cfg.logging == 'STDOUT'
        target = STDOUT
      else
        Process.daemon
        target = Cfg.logging
      end
      Log = Logger.new target
    end
  end

  class Core

    def initialize
      File.open(Cfg.pidfile, 'w') do |wr|
        wr.puts $$
      end
    end

    def run
      while true do
        collector 	= Metrics.new
        metrics 	= collector.collect
        if metrics.count > 0
          sender  	= Sender.new(metrics)
        else
          Log.debug 'no metrics collected ..' if Cfg.debug
        end
        sleep Cfg.collect.looptime
      end
    end

  end
end
    
