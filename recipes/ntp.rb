#
## Cookbook:: esnbootstrap
## Recipe:: default
##
## Copyright:: 2022, Andrei Lalla, All Rights Reserved.
##
#

package 'chrony' do
  action :install
  not_if { ::File.exist?('/etc/chrony.conf') }
end

service 'chronyd' do
  action :nothing
  supports status: 'true', start: 'true', stop: 'true', restart: 'true'
end

template '/etc/chrony.conf' do
  source 'chrony.conf.erb'
  owner 'root'
  group 'root'
  mode '0755'
  notifies :restart, 'service[chronyd]', :immediately
end

execute 'chrony_check' do
  command 'chronyc sources'
  action :run
end
