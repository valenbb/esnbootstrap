#
# Cookbook:: esnbootstrap
# Recipe:: default
#
# Copyright:: 2017, Andrei Lalla, All Rights Reserved.
#

# --------------------------------------------------------------------
# Disable firewall
# --------------------------------------------------------------------
case node['platform']
when 'ubuntu', 'debian'
  execute 'disable_firewall' do
    command 'ufw --disable'
  end
when 'centos', 'redhat', 'amazon', 'scientific', 'oracle'
  bash 'disable_firewall' do
    user 'root'
    code <<-EOH
      systemctl stop firewalld
      systemctl disable firewalld
      EOH
  end
when 'centos', 'redhat', 'amazon', 'scientific', 'oracle' 
  execute 'disable_firewall' do
    command "systemctl stop firewalld && systemctl disable firewalld"
  end
end

# --------------------------------------------------------------------
# Disable SELinux
# --------------------------------------------------------------------
case node['platform']
when 'centos', 'redhat', 'scientific', 'oracle', 'amazon'
  bash 'disable_selinux' do
    user 'root'
    code <<-EOH
      setenforce 0
      sed -i 's/SELINUX=enforcing/SELINUX=disabled/g'/etc/selinux/config
      EOH
  end
end

# --------------------------------------------------------------------
# Disable NetworkManager
# --------------------------------------------------------------------
case node['platform']
when 'centos', 'redhat', 'amazon', 'scientific', 'oracle'
  bash 'disable_netmgr' do
    user 'root'
    code <<-EOH
      systemctl stop NetworkManager
      systemctl disable NetworkManager"
      EOH
  end
end
