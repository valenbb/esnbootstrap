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
when 'ubuntu'
  execute 'disable_firewall' do
    command "ufw --disable"
  end
when 'centos' && node['platform_version'].to_f >= 7.0
  execute 'disable_firewall' do
    command "systemctl stop firewalld && systemctl disable firewalld"
  end
end

# --------------------------------------------------------------------
# Disable SELinux
# --------------------------------------------------------------------
case node['platform']
when 'ubuntu'
  execute 'disable_apparmor' do
    command "sudo /etc/init.d/apparmor stop && sudo update-rc.d -f apparmor remove"
  end
when 'centos', 'redhat'
  execute 'disable_selinux' do
    command "setenforce 0 && sed -i 's/SELINUX=enforcing/SELINUX=disabled/g'/etc/selinux/config"
  end
end

# --------------------------------------------------------------------
# Disable NetworkManager
# --------------------------------------------------------------------
case node['platform']
when 'centos' && node['platform_version'].to_f >= 7.0
  execute 'disable_netmgr' do
    command "systemctl stop NetworkManager && systemctl disable NetworkManager"
  end
end

