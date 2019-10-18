#! /usr/bin/env ruby
#
#   metrics-jmx
#
# DESCRIPTION:
#   This plugin uses the JMX gem to collect metrics
#   from a running JAVA process with an enabled JMX interface.
#
# OUTPUT:
#   metric data
#
# PLATFORMS:
#   Linux
#
# DEPENDENCIES:
#   gem: sensu-plugin
#   gem: jmx
#
# USAGE:
#
# NOTES:
#
# LICENSE:
#   Copyright 2019 Jason Westervelt <jason.westervelt@protonmail.com>
#   Released under the same terms as Sensu (the MIT license); see LICENSE
#   for details.
#

require 'sensu-plugin/metric/cli'
require 'jmx'
require 'socket'

class JMXGraphite < Sensu::Plugin::Metric::CLI::Graphite
  option :scheme,
         description: 'Metric naming scheme, text to prepend to .$parent.$child',
         long: '--scheme SCHEME',
         default: "#{Socket.gethostname}.jmx"

  option :port,
         description: 'JMX listening port',
         short: '-P',
         long: '--port',
         required: true

  option :domain,
         description: 'JMX domain name',
         short: '-D',
         long: '--domain',
         required: true

  option :bean,
         description: 'JMX bean name',
         short: '-B',
         long: '--bean',
         required: true

  option :attribute,
         description: 'JMX attribute name',
         short: '-A',
         long: '--attribute',
         required: true

  option :key,
         description: 'JMX key name',
         short: '-K',
         long: '--key',
         required: true

  option :username,
         description: 'JMX username',
         short: '-u',
         long: '--username'

  option :attribute,
         description: 'JMX password',
         short: '-p',
         long: '--password'

  def run
    client = JMX.connect(host: 'localhost', port: config[:port])
    timestamp = Time.now.to_i
    metrics = client['java.lang:type=Memory']

    metrics.each do |parent, children|
      children.each do |child, value|
        output [config[:scheme], parent, child].join('.'), value, timestamp
      end
    end
    ok
  end
end
