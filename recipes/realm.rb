#
## Cookbook:: esnbootstrap
## Recipe:: realm
##
## Copyright:: 2017, Andrei Lalla, All Rights Reserved.
##
#

include_recipe 'chef-vault'

if node['realm']['join']
  node['sssd']['packages'].each do |pkg|
    package(pkg) do
      provider Chef::Provider::Package::Yum if node.platform_family?('centos')
    end
  end
end

begin
  realm_info = chef_vault_item_for_environment(node['realmd-sssd']['vault-name'],
                                               node['realmd-sssd']['vault-item'])
  realm_info = realm_info.empty? ?
    chef_vault_item(node['realmd-sssd']['vault-name'], node['realmd-sssd']['vault-item']) :
    realm_info.select { |key| %w[password realm username].include? key }
  rescue Exception => e
    Chef::Application.fatal!(e.to_s)
end

bash 'join domain' do
  user 'root'
  code <<-EOH
    realm discover #{realm_info['realm']}
    echo -n '#{realm_info['password']}' | realm join -v --unattended -U #{realm_info['username']} #{realm_info['realm']}
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
  supports :status => true, :restart => true
  action [:enable, :start]
end
