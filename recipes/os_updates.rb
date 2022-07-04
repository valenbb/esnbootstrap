#
# Cookbook:: esnbootstrap
# Recipe:: default
#
# Copyright:: 2022, Andrei Lalla, All Rights Reserved.
#

case node['platform']
when 'ubuntu'
  execute 'apt_update' do
    command 'apt-get update && apt-get upgrade -y'
  end
when 'centos', 'rocky'
  execute 'apt_update' do
    command 'localectl set-locale LANG=en_US.UTF-8 && yum clean all && yum update -y'
  end
end
