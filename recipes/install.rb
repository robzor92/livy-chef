#
# Cookbook Name:: livy
# Recipe:: install
#
# Copyright 2016, Jim Dowling
#
# All rights reserved
#

include_recipe "hops::wrap"

my_ip = my_private_ip()

package_url = "#{node.livy.url}"
base_package_filename = File.basename(package_url)
cached_package_filename = "#{Chef::Config.file_cache_path}/#{base_package_filename}"

remote_file cached_package_filename do
  source package_url
  owner "#{node.livy.user}"
  mode "0644"
  action :create_if_missing
end


package "unzip" do
end

# Extract Livy
livy_downloaded = "#{node.livy.dir}/.livy_extracted_#{node.livy.version}"

bash 'extract-livy' do
        user "root"
        group node.livy.group
        code <<-EOH
                set -e
                unzip #{cached_package_filename} -d #{Chef::Config.file_cache_path}
                mv #{Chef::Config.file_cache_path}/livy-server-#{node.livy.version} #{node.livy.dir}
                # remove old symbolic link, if any
                rm -f #{node.livy.home}
                ln -s #{node.livy.base_dir} #{node.livy.home}
                chown -R #{node.livy.user}:#{node.livy.group} #{node.livy.base_dir}
                touch #{livy_downloaded}
                chown -R #{node.livy.user}:#{node.livy.group} #{livy_downloaded}
        EOH
     not_if { ::File.exists?( "#{livy_downloaded}" ) }
end



