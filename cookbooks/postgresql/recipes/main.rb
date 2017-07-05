package 'postgresql-server' do 
    notifies :run, 'execute[postgresql-init]'
end
package 'postgresql-contrib' do
    action :install
end

execute 'postgresql-init' do
    command 'postgresql-setup initdb'
    action :nothing
end


service 'postgresql' do
    action [:enable, :start]
end

#execute	'postgresql' do
#    command 'systemctl start postgresql'
#    action :nothing
#end	

#execute 'postgresql' do
#    command 'systemctl enable postgresql'
#    action :nothing
#end

