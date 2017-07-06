node.set['mysql']['server_root_password'] = node['mediawiki']['mysql_root_pw']

# install the database software
include_recipe 'mysql::server'

# create the database
include_recipe 'database::mysql'

mysql_connection_info = {
  host: 'localhost',
  username: 'root',
  password: node['mediawiki']['mysql_root_pw']
}

mysql_database node['mediawiki']['apps'] do
  connection mysql_connection_info
  action :create
end

mysql_database_user node['mediawiki']['admin'] do
  connection mysql_connection_info
  password node['mediawiki']['password']
  action :create
end

mysql_database_user node['mediawiki']['admin'] do
  connection mysql_connection_info
  password node['mediawiki']['password']
  database_name node['mediawiki']['apps']
  host node['mediawiki']['apps_server']
  action :grant
end
