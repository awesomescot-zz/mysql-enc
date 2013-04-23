require "rubygems"
require "mysql2"
require "yaml"

config_file = File.join(File.dirname(__FILE__),"config.yml")

unless File.exist?(config_file)
  puts <<END
You must have config.yml in the current directory:

db_host: HOSTNAME_OF_DB
db_user: DB_USERNAME
db_password: DB_PASSWORD
db_name: NAME_OF_THE_DB_YOU_WOULD_LIKE_TO_USE

END
  exit 1
end

config = YAML.load(File.read(config_file))

unless config.kind_of?(Hash)
  puts <<END
config.yml is formatted incorrectly. Please use the following:

db_host: HOSTNAME_OF_DB
db_user: DB_USERNAME
db_password: DB_PASSWORD
db_name: NAME_OF_THE_DB_YOU_WOULD_LIKE_TO_USE

END
  exit 1
end


@db_host = config["db_host"]
@db_user = config["db_user"]
@db_password = config["db_password"]
@db_name = config["db_name"]


