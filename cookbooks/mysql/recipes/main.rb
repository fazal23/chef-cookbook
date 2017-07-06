#execute 'update' do
 # command 'sudo yum install wget'
 # command 'sudo yum update'
#end

package 'wget' do
  action :install
end

execute 'wget' do
  command 'sudo wget http://repo.mysql.com/mysql-community-release-el7-5.noarch.rpm'
end

execute 'rpm' do
  command 'sudo rpm -ivh mysql-community-release-el7-5.noarch.rpm'
end


#execute 'rpm' do
#  command 'sudo yum install mysql-server'
#end

package 'mysql-server' do
  action :install
end

service 'mysqld' do
  action :start
end
#execute 'rpm' do
#  command 'sudo systemctl start mysqld'
#end


execute 'harden' do
  command ' sudo mysql_secure_installation'
end


