#
# Cookbook:: esnbootstrap
# Recipe:: default
#
# Copyright:: 2022, Andrei Lalla, All Rights Reserved.
#

# --------------------------------------------------------------------
# Disable firewall
# --------------------------------------------------------------------
case node['platform']
when 'ubuntu'
  execute 'disable_firewall' do
    command 'ufw --disable'
  end
when 'centos', 'rocky'
  ['firewalld', 'NetworkManager'].each do |s|
    service s do
      action [:stop, :disable]
    end
  end
end

# --------------------------------------------------------------------
# Disable SELinux
# --------------------------------------------------------------------
case node['platform']
when 'centos', 'rocky'
  bash 'disable_selinux' do
    user 'root'
    code <<-EOH
      setenforce 0
      sed -i 's/SELINUX=enforcing/SELINUX=disabled/g' /etc/selinux/config
      EOH
  end
end
