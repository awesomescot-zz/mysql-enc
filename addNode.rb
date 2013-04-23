#!/usr/bin/env ruby

require File.expand_path(File.dirname(__FILE__) + '/include.rb')
require 'optparse'


opt_parser = OptionParser.new do |opt|
  opt.banner = "Usage: addNode.rb FQDN ENVIRONMENT [CLASSES]"
  opt.separator  ""
  opt.separator  "eg: addNode.rb web2.my.domain web_server api_lb_server"
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

fqdn,env,*classes = ARGV

client = Mysql2::Client.new(:host => @db_host, :username => @db_user, :password => @db_password, :database => @db_name)

results = client.query("SELECT * FROM nodes where fqdn = \"#{fqdn}\"")
if results.any?
  puts "The node \"#{fqdn}\" already exists"
  exit 1
end
class_string = ""
if classes
  class_string = classes.join(",")
end
node_name = fqdn.split(".")[0]
query = "INSERT INTO nodes (hostname, fqdn, env, classes) VALUES (\"#{node_name}\",\"#{fqdn}\",\"#{env}\",\"#{class_string}\")"
puts query
client.query(query)
puts "Node inserted successfully"
