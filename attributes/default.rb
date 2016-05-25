include_attribute "kagent"
include_attribute "hops"
include_attribute "apache_hadoop"
include_attribute "hadoop_spark"
include_attribute "hopsworks"

default.livy.user                    = node.hadoop_spark.user
default.livy.group                   = node.hadoop_spark.group

default.livy.version                 = "0.3.0-SNAPSHOT"
default.livy.url                     = "#{node.download_url}/livy-server-#{node.livy.version}.zip"
default.livy.port                    = "8998"
default.livy.dir                     = "/srv"
default.livy.base_dir                =  node.livy.dir + "/livy-server-" + node.livy.version
default.livy.home                    =  node.livy.dir + "/livy-server" 
default.livy.keystore                = "#{node.kagent.base_dir}/node_server_keystore.jks"
default.livy.keystore_password       = node.hopsworks.master.password

default.livy.systemd                 = "true"
