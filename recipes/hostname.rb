#
# Cookbook:: esnbootstrap
# Recipe:: hostname
#
# Copyright:: 2017, Andrei Lalla, All Rights Reserved.
#

hostname = node['hosname']

fqdn = node['realm]['sssd_domain']

case node['platform']
when 'centos' && node['platform_version'].to_f >= 7
  bash 'set hostname' do
    user 'root'
    code <<-EOH
      hostnamectl set-hostname #{hostname}.#{fqdn}
      EOH
    notifies :reload, 'ohai[reload_hostname]', :immediately
  end
end

when 'ubuntu' && node['platform_version'].to_f = 16.04
  bash 'set hostname' do
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

