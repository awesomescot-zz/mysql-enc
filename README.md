mysql-enc
=========

mysql-enc is a puppet enc (external node classifier) that uses mysql for the backend.

## Installation

You will need to create a file called config.yml in the directory with the scripts.  It should look like this:

db_host: HOSTNAME_OF_DB
db_user: DB_USERNAME
db_password: DB_PASSWORD
db_name: NAME_OF_THE_DB_YOU_WOULD_LIKE_TO_USE


## Documentation

Thus far this is a very simple implimentation of an enc.  I'm just storing environment and classes in the db for a givin node.

### addNode.rb
Usage: addNode.rb FQDN ENVIRONMENT [CLASSES]

eg: addNode.rb web2.my.domain prod web_server api_lb_server

OPTIONS:
    -h, --help                       help

### classify.rb
This is the file that puppet will call with the fqdn.  It will return yaml of the node's classes and environment.  If the node is not found it returns nothing, but has an exit status of 0, so there is no error.  This is so that you can have a node that is defined in site.pp and not in the db.

eg. classify.rb test.my.domain

### createDB.rb
This will drop and then create a db called 'enc'

It will then create the table called nodes with id, hostname, fqdn, environment, classes, time_created
