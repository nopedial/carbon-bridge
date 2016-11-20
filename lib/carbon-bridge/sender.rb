module CarbonBridge
  class Sender

    def initialize carbon_host, carbon_port, carbon_proto='udp', metrics, debug
      @carbon_host 	= carbon_host
      @carbon_port 	= carbon_port
      @carbon_proto	= carbon_proto
      @metrics		= metrics
      @debug		= debug
      @hostname		= `hostname`.chop.split('.').join('-')
      _send
    end

    def _send
      begin
        case @carbon_proto
        when 'udp'
          @tx_sock = UDPSocket.new
          @metrics.each do |metric|
            @tx_sock.send [ [ @hostname, metric[1] ].join('.'), metric[2], metric[0] ].join(' '), 0, @carbon_host, @carbon_port
          end
        when 'tcp'
          r = Random.new
          @tx_sock = TCPSocket.new @carbon_host, @carbon_port
          @metrics.each do |metric|
            # inbound metric = timestamp, metric_name, value => outbound metric: hostname.metric.name value timestamp
            @tx_sock.write [ [ @hostname, metric[1] ].join('.'), metric[2], metric[0] ].join(' ')
          end
        end
        Log.debug [ 'metric sent to carbon-cache server', [ @carbon_host, @carbon_proto, @carbon_port ].join(':') ].join(' ') if @debug
        @tx_sock.close
      rescue => e
        Log.error e
        exit 0
      end
    end

  end
end
