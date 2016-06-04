action :restart do

  bash "restart-livy" do
    user "root"
    code <<-EOF
       service livy restart
    EOF
  end
 
end
