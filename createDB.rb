require "rubygems"
#gem "mysql2", "~> 0.2.7"
require "mysql2"

@db_host = "localhost"
@db_user = "root"
@db_password = "puppet"
@db_name = "enc"

client = Mysql2::Client.new(:host => @db_host, :username => @db_user, :password => @db_password)

client.query("DROP DATABASE IF EXISTS #{@db_name}")
client.query("CREATE DATABASE #{@db_name}")
client.query("show databases").each(:as => :array) do |row|
  puts row
end
client.query("grant all on enc.* to '%'@'localhost';")
client.query("use enc")
client.query("CREATE TABLE nodes ( id INT NOT NULL AUTO_INCREMENT PRIMARY KEY, nodename VARCHAR(100), classes VARCHAR(200), created TIMESTAMP DEFAULT NOW() )")
