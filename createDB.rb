#!/usr/bin/env ruby

require File.expand_path(File.dirname(__FILE__) + '/include.rb')

client = Mysql2::Client.new(:host => @db_host, :username => @db_user, :password => @db_password)

client.query("DROP DATABASE IF EXISTS #{@db_name}")
client.query("CREATE DATABASE #{@db_name}")
client.query("grant all on enc.* to '%'@'localhost';")
client.query("use enc")
client.query("CREATE TABLE nodes ( id INT NOT NULL AUTO_INCREMENT PRIMARY KEY, hostname VARCHAR(100), fqdn VARCHAR(100), env VARCHAR(100), classes VARCHAR(200), created TIMESTAMP DEFAULT NOW() )")

puts "Database: \"#{@db_name}\" has been successfully created"
