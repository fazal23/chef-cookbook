package 'php' do
  action :install
end

package 'php-pgsql' do
  action :install
end

service 'httpd' do
  action :start 
end
