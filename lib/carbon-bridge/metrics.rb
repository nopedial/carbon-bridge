module CarbonBridge
  class Metrics

    def initialize
    end

    def collect
      begin
        metrics = []
        Dir.entries(Cfg.collect.plugins).each do |plugin|
          next if plugin == '.' or plugin == '..'
          Log.debug [ 'running script ', plugin ].join if Cfg.debug
          metric = `#{File.join(Cfg.collect.plugins, plugin)}`
          if metric[-1] == "\n"
            Log.debug 'removing trailing characters ..' if Cfg.debug
            metric = metric.chop
          end
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
