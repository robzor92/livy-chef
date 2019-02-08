include_attribute "kagent"

default['livy']['user']                    = node['install']['user'].empty? ? "livy" : node['install']['user']
default['livy']['group']                   = node['install']['user'].empty? ? node['hadoop_spark']['group'] : node['install']['user']

default['livy']['version']                 = "0.6.0.0-incubating-bin"
default['livy']['url']                     = "#{node['download_url']}/robin/livy-#{node['livy']['version']}.zip"
default['livy']['port']                    = "8998"
default['livy']['dir']                     = node['install']['dir'].empty? ? "/srv" : node['install']['dir']
default['livy']['home']                    = node['livy']['dir'] + "/livy-" + node['livy']['version']
default['livy']['base_dir']                = node['livy']['dir'] + "/livy"
default['livy']['keystore']                = "#{node['kagent']['certs_dir']}/keystores/#{node['hostname']}__kstore.jks"
default['livy']['keystore_password']       = node['hopsworks']['master']['password']

default['livy']['pid_file']                = "/tmp/livy.pid"
default['livy']['log']                     = "#{node['livy']['base_dir']}/logs/livy-logfile.log"
default['livy']['log_size']                = "20MB"

default['livy']['systemd']                 = "true"
default['livy']['rsc']['rpc']['max']['size'] =  "268435456"
default['livy']['rpc']['max']['size'] =  "268435456"
