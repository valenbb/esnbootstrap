#
## Cookbook:: esnbootstrap
## Recipe:: realm
##
## Copyright:: 2017, Andrei Lalla, All Rights Reserved.
##
#

data = data_bag_item('realm', 'sssd')

bash "joining #{data['domain']} domain" do
  user 'root'
  code <<-EOH
    realm discover #{data['domain']}
    echo -n '#{data['password']}' | realm join -v --unattended -U #{data['username']} #{data['domain']}
  EOH
end

template "node['realm']['sssd_path']" do
  source 'sssd.conf.erb'
  owner 'root'
  group 'root'
  mode '0600'
  notifies :restart, 'service[sssd]', :immediately
end

service 'sssd' do
  supports status: 'true', restart: 'true'
  action [:enable, :start]
end
