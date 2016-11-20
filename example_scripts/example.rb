#!/usr/bin/env ruby

# return uptime in days

begin
  up = `uptime | awk '{print $3}'`.chop
  print [ 'system-metrics.uptime', up ].join(' ')
end
