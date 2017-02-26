#
# Cookbook:: esnbootstrap
# Recipe:: hostname
#
# Copyright:: 2017, Andrei Lalla, All Rights Reserved.
#

hostname = node['hosname']['server_name']

fqdn = node['realm']['sssd_domain']

case node['platform']
when 'centos', 'redhat', 'amazon', 'scientific', 'oracle'
  bash 'set hostname' do
    user 'root'
    code <<-EOH
      hostnamectl set-hostname #{hostname}.#{fqdn}
      EOH
    notifies :reload, 'ohai[reload_hostname]', :immediately
  end
when 'ubuntu', 'debian'
  bash 'set_hostname' do
    code <<-EOH
      sudo hostnamectl set-hostname #{hostname}.#{fqdn}
      EOH
    notifies :reload, 'ohai[reload_hostname]', :immediately
  end
end

ohai 'reload_hostname' do
  plugin 'hostname'
  action :nothing
end
