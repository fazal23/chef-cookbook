%w(graphviz aspell php-gd php-intl php-xml git wget).each do |package|
  package package do
    action :install
  end
end

service 'httpd' do
  action  :restart
end

#remote_file '/var/www/' + node['mediawiki']['apps'] + '.tar.gz' do
#  owner 'root'
#  group 'root'
#  mode '0644'
#  source node['mediawiki']['link']
#  not_if { ::File.exist?('/var/www/' + node['mediawiki']['apps'] + '.tar.gz') }
#end


execute 'wget' do
  command 'wget http://releases.wikimedia.org/mediawiki/1.24/mediawiki-1.24.1.tar.gz'
end

execute 'wget' do
  command 'tar -zxvf mediawiki-1.24.1.tar.gz'
end

execute 'wget' do
  command 'mv mediawiki-1.24.1/* /var/www/html'
end

