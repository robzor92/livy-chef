bash 'kill_running_interpreters' do
    user "root"
    ignore_failure true
    code <<-EOF
      service livy stop
    EOF
end
ss

directory node['livy']['home'] do
  recursive true
  action :delete
  ignore_failure true
end

link node['livy']['base_dir'] do
  action :delete
  ignore_failure true
end


package_url = "#{node['livy']['url']}"
base_package_filename = File.basename(package_url)
cached_package_filename = "/tmp/#{base_package_filename}"

file cached_package_filename do
  action :delete
  ignore_failure true
end

