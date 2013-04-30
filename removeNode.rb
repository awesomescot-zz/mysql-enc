#!/usr/bin/env ruby

require File.expand_path(File.dirname(__FILE__) + '/include.rb')
require 'optparse'


opt_parser = OptionParser.new do |opt|
  opt.banner = "Usage: removeNode.rb FQDN"
  opt.separator  ""
  opt.separator  "eg: removeNode.rb web2.my.domain"
  opt.separator  ""
  opt.separator  "OPTIONS:"
  opt.on("-h","--help","help") do
    puts opt_parser
    exit
  end
end

opt_parser.parse!

if ARGV.length != 1
  puts opt_parser
  exit
end

fqdn = ARGV[0]

client = Mysql2::Client.new(:host => @db_host, :username => @db_user, :password => @db_password, :database => @db_name)

results = client.query("SELECT * FROM nodes where fqdn = \"#{fqdn}\"")
if results.any?
  client.query("DELETE FROM nodes WHERE fqdn = '#{fqdn}'")
  exit
else
  puts "There is no entry for #{fqdn}, so I can't delete it"
  exit 1
end
puts "Node removed successfully: #{fqdn}"
