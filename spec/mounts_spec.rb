
# The MIT License (MIT)
#
# Copyright (c) 2015-16 Comcast Technology Solutions
#
#     Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the "Software"), to deal
# in the Software without restriction, including without limitation the rights
# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions:
#
# The above copyright notice and this permission notice shall be included in
# all copies or substantial portions of the Software.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
# THE SOFTWARE.

require 'linux_stats'

include LinuxStats::OS

describe 'Partition Report' do
  it 'SENSU-261 -- it should calculate correct disk used percent' do
    reporter = Mounts::Reporter.new
    reporter.report.each do |_, val|
      avail = val[:available_kb].to_f
      total = val[:total_kb].to_f
      # puts("Part: #{key},  Avail: #{avail}, tot: #{total}")
      expect(val[:used_pct]).to eq 100.0 * (1 - avail / total) unless total == 0
    end
  end
end

describe 'module functions' do
  it 'should generate a happy path report' do
    reporter = Mounts::Reporter.new
    data = reporter.report
    expect(data.key? '/').to be true
  end
end
