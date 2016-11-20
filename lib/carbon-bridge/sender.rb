module CarbonBridge
  class Sender

    def initialize metrics
      @metrics		= metrics
      @hostname		= `hostname`.chop.split('.').join('-')
      threads 		= []
      Cfg.carbon.server_ip.each do |cho|
        threads << Thread.new {
          _send(cho)
        }
      end
      threads.each(&:join)
    end

    def _send carbon_host
      begin
        case Cfg.carbon.tx_protocol
        when 'udp'
          @tx_sock = UDPSocket.new
          @metrics.each do |metric|
            @tx_sock.send [ [ @hostname, metric[1] ].join('.'), metric[2], metric[0] ].join(' '), 0, carbon_host, Cfg.carbon.server_port
            Log.debug [ 'metric sent to carbon-cache - ', [ [ @hostname, metric[1] ].join('.'), metric[2], metric[0] ].join(' '), ' -> ', [ carbon_host, Cfg.carbon.server_port ].join(':') ].join if Cfg.debug
          end
        when 'tcp'
          @tx_sock = TCPSocket.new carbon_host, Cfg.carbon.server_port
          @metrics.each do |metric|
            @tx_sock.write [ [ @hostname, metric[1] ].join('.'), metric[2], metric[0] ].join(' ')
            Log.debug [ 'metric sent to carbon-cache - ', [ [ @hostname, metric[1] ].join('.'), metric[2], metric[0] ].join(' '), ' -> ', [ carbon_host, Cfg.carbon.server_port ].join(':') ].join if Cfg.debug
          end
        end
      rescue => e
        Log.error e
        exit 0
      end
    end

  end
end
