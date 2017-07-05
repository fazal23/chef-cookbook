%w(graphviz aspell php5-pspell php5-curl php5-gd php5-intl php5-mysql php5-xmlrpc php5-ldap php-apc git).each do |package|
  package package do
    action :install
  end
end

node.default['apache']['mpm'] = 'prefork'

include_recipe 'apache2::default'
include_recipe 'apache2::mod_php5'

remote_file '/var/www/' + node['mediawiki']['apps'] + '.tar.gz' do
  owner 'root'
  group 'root'
  mode '0644'
  source node['mediawiki']['link']
  not_if { ::File.exist?('/var/www/' + node['mediawiki']['apps'] + '.tar.gz') }
end

bash 'Install mediawiki' do
  user 'root'
  cwd '/var/www'
  code <<-EOH
  tar -xvzf #{node['mediawiki']['apps']}.tar.gz -C .
  mv #{node['mediawiki']['apps']}-#{node['mediawiki']['version']} #{node['mediawiki']['apps']}
  /usr/bin/php #{node['mediawiki']['apps']}/maintenance/install.php --conf #{node['mediawiki']['apps']}/LocalSettings.php #{node['mediawiki']['title']} admin --pass #{node['mediawiki']['password']} --dbname #{node['mediawiki']['apps']} --dbuser #{node['mediawiki']['admin']} --dbpass #{node['mediawiki']['password']} --dbserver #{node['mediawiki']['db_server']} --lang #{node['mediawiki']['lang']} --scriptpath 'http://#{node['mediawiki']['domain']}'
  chown www-data: -R #{node['mediawiki']['apps']}
  EOH
  not_if { ::File.exist?('/var/www/' + node['mediawiki']['apps'] + '/LocalSettings.php') }
end

web_app node['mediawiki']['apps'] do
  server_name node['mediawiki']['domain']
  docroot '/var/www/' + node['mediawiki']['apps']
  cookbook 'apache2'
end
