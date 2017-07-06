if node['platform_family'] == "rhel"
    package = "httpd"
elsif node['platform_family'] == "debian"
    package = "apache2"
end

package 'apache2' do
    package_name package
    action :install
end


service 'apache2' do
    service_name package 
    action [:start, :enable]
end

#cookbook_file "/var/www/html/index.html" do
#  source "index.html"
# mode "0644"
#end

