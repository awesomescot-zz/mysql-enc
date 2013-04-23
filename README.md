mysql-enc
=========

mysql-enc is a puppet enc (external node classifier) that uses mysql for the backend.

## Installation

Because I will be using these scripts in different places(ie. classify.rb is on the puppet server, and addNode.rb will be on my node generation server), I've included the configuration in all the scripts. If anyone has a better method for this, please let me know.

## Documentation

Thus far this is the most simple implimentation of an enc.  I'm just storing environment and classes in the db for a givin node.

### addNode.rb
Usage: addNode.rb NODENAME ENVIRONMENT [CLASSES]

eg: addNode.rb web2 prod web_server api_lb_server

OPTIONS:
    -h, --help                       help

### classify.rb
This is the file that puppet will call with the fqdn.

eg. classify.rb test.my.domain

### createDB.rb
This will drop and then create a db called 'enc'

It will then create the table:
CREATE TABLE nodes ( 
  id INT NOT NULL AUTO_INCREMENT PRIMARY KEY, 
  hostname VARCHAR(100), 
  fqdn VARCHAR(100), 
  env VARCHAR(100), 
  classes VARCHAR(200), 
  created TIMESTAMP DEFAULT NOW() )
