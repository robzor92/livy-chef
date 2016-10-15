#
# Cookbook Name:: livy
# Recipe:: install
#
# Copyright 2016, Jim Dowling
#
# All rights reserved
#


include_recipe "java"

include_recipe "hops::wrap"

my_ip = my_private_ip()

group node.livy.group do
  action :create
  not_if "getent group #{node.livy.group}"
end

user node.livy.user do
  home "/home/#{node.livy.user}"
  action :create
  system true
  shell "/bin/bash"
  manage_home true
  not_if "getent passwd #{node.livy.user}"
end

group node.livy.group do
  action :modify
  members ["#{node.livy.user}"]
  append true
end


package_url = "#{node.livy.url}"
base_package_filename = File.basename(package_url)
cached_package_filename = "/tmp/#{base_package_filename}"

remote_file cached_package_filename do
  source package_url
  owner "#{node.livy.user}"
  mode "0644"
  action :create_if_missing
end


package "unzip" do
end

# Extract Livy
livy_downloaded = "#{node.livy.home}/.livy_extracted_#{node.livy.version}"

bash 'extract-livy' do
        user "root"
        group node.livy.group
        code <<-EOH
                set -e
                unzip #{cached_package_filename} -d /tmp
                mv /tmp/livy-server-#{node.livy.version} #{node.livy.dir}
                # remove old symbolic link, if any
                rm -f #{node.livy.home}
                ln -s #{node.livy.home} #{node.livy.base_dir}
                chown -R #{node.livy.user}:#{node.livy.group} #{node.livy.home}
                chown -R #{node.livy.user}:#{node.livy.group} #{node.livy.base_dir}
                touch #{livy_downloaded}
                chown -R #{node.livy.user}:#{node.livy.group} #{livy_downloaded}
        EOH
     not_if { ::File.exists?( "#{livy_downloaded}" ) }
end



