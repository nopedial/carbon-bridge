module CarbonBridge

  if File.exists? '/etc/carbon-bridge/config'
    Cfg  			= Asetus.cfg name: 'carbon-bridge'
  else
    CFG = Asetus.new :name=>'carbon-bridge', :load=>false
    CFG.default.debug 			= true
    CFG.default.logging			= 'STDOUT'
    CFG.default.collect.looptime 	= 300
    CFG.default.collect.plugins		= '~/.config/carbon-bridge/plugins'
    CFG.default.carbon.server_ip	= '127.0.0.1'
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
        target = Cfg.logging
      end
      Log = Logger.new target
    end
  end

  class Core

    def initialize
    end

    def run
      while true do
        Log.debug 'collecting metrics ..' if Cfg.debug
        collector 	= Metrics.new(Cfg.collect.plugins, Log, Cfg.debug)
        metrics 	= collector.collect
        if metrics.count > 0
          Log.debug 'sending metrics ..' if Cfg.debug
          sender  	= Sender.new(Cfg.carbon.server_ip, Cfg.carbon.server_port, Cfg.carbon.tx_protocol, metrics, Cfg.debug)
        else
          Log.debug 'no metrics collected ..' if Cfg.debug
        end
        sleep Cfg.collect.looptime
      end
    end

  end
end
    
