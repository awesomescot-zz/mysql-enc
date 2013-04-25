#!/usr/bin/env ruby

require File.expand_path(File.dirname(__FILE__) + '/include.rb')

client = Mysql2::Client.new(:host => @db_host, :username => @db_user, :password => @db_password, :database => @db_name)

if ARGV.length != 1
  exit 1
end

class_string = client.query("select classes,env from nodes where fqdn = \"#{ARGV[0]}\"")
if class_string.any?
  classes = class_string.first["classes"].split(",")
  env = class_string.first["env"]
  puts({ "classes" => classes, "environment" => env }.to_yaml)
else
  puts({ "classes" => nil, "environment" => nil }.to_yaml)
end
