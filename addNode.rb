#!/usr/bin/env ruby

require 'optparse'
require "rubygems"
#gem "mysql2", "~> 0.2.7"
require "mysql2"


opt_parser = OptionParser.new do |opt|
  opt.banner = "Usage: addNode.rb NODENAME ENVIRONMENT [CLASSES]"
  opt.separator  ""
  opt.separator  "eg: addNode.rb web2 web_server api_lb_server"
  opt.separator  ""
  opt.separator  "OPTIONS:"
  opt.on("-h","--help","help") do
    puts opt_parser
    exit
  end
end

opt_parser.parse!

if ARGV.length < 2
  puts opt_parser
  exit
end

node_name,env,*classes = ARGV

@db_host = "localhost"
@db_user = "root"
@db_password = "puppet"
@db_name = "enc"

client = Mysql2::Client.new(:host => @db_host, :username => @db_user, :password => @db_password, :database => @db_name)


class_string = ""
if classes
  class_string = classes.join(",")
end
fqdn = "#{node_name}.datareadings.com"
query = "INSERT INTO nodes (hostname, fqdn, env, classes) VALUES (\"#{node_name}\",\"#{fqdn}\",\"#{env}\",\"#{class_string}\")"
puts query
puts client.query(query)
