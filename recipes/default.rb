#
# Cookbook:: esnbootstrap
# Recipe:: default
#
# Copyright:: 2017, Andrei Lalla, All Rights Reserved.
#
if node['realm']['join']
  include_recipe 'esnbootstrap::realm'
end

include_recipe 'hostnames::default'

include_recipe 'esnbootstrap::ntp'

include_recipe 'esnspacewalk::client'

