#!/usr/bin/env ruby

require "rubygems"
#gem "mysql2", "~> 0.2.7"
require "mysql2"
require "yaml"

@db_host = "localhost"
@db_user = "root"
@db_password = "puppet"
@db_name = "enc"

client = Mysql2::Client.new(:host => @db_host, :username => @db_user, :password => @db_password, :database => @db_name)

if ARGV.length != 1
  exit 1
end

class_string = client.query("select classes,env from nodes where fqdn = \"#{ARGV[0]}\"")
classes = class_string.first["classes"].split(",")
env = class_string.first["env"]
puts({ "classes" => classes, "environment" => env }.to_yaml)
