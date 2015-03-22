#!/usr/bin/env ruby

require 'time'
require 'pl_procstat'
require 'json'

# This executable may serve as a useful command-line tool,
# but its primary purpose is to provide an example client
# for the stats library.

DEFAULT_DELAY_SEC = 0.2
DEFAULT_ITERATIONS = 100
PROCESS_NAME = 'chrome'

delay_sec = ARGV[0] ? ARGV[0].to_i : DEFAULT_DELAY_SEC
iterations = ARGV[1] ? ARGV[1].to_i : DEFAULT_ITERATIONS

stats = Procstat::LinuxStats.new
stats.report
total_time = 0.0
iterations.times do
  sleep(delay_sec)
  start = Time.now
  report = Procstat.pids(PROCESS_NAME)
  elapsed_time = Time.now - start
  total_time += elapsed_time
  puts JSON.pretty_generate report
  puts "Generating the report took #{elapsed_time*1000} ms"
end
puts "Total time: #{total_time * 1000.0} ms, mean: #{1000.0 *total_time/iterations} ms"