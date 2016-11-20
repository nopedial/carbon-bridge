module CarbonBridge
  Directory = File.expand_path File.join File.dirname(__FILE__), '../'
  require 'asetus'
  require 'logger'
  require 'socket'
  require 'carbon-bridge/core'
  require 'carbon-bridge/metrics'
  require 'carbon-bridge/sender'
end
