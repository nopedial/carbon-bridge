module CarbonBridge
  class Metrics

    def initialize plugin_dirs, log, debug
      @plugin_dirs 	= plugin_dirs
      @log 		= log
      @debug 		= debug
    end

    def collect
      begin
        metrics = []
        Dir.entries(@plugin_dirs).each do |plugin|
          next if plugin == '.' or plugin == '..'
          @log.debug [ 'running script ', plugin ].join if @debug
          metric = `#{File.join(@plugin_dirs, plugin)}`
          metrics << [ Time.now.to_i, metric.split(' ')[0], metric.split(' ')[1] ] # timestamp, metric name, value
        end
        return metrics
      rescue => e 
        Log.warn e
        return [ ]
      end
    end
  end
end
