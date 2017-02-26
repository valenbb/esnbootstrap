#
# Cookbook:: esnbootstrap
# Recipe:: default
#
# Copyright:: 2017, Andrei Lalla, All Rights Reserved.
#

include_recipe 'esnbootstrap::realm' if node['realm']['join']

include_recipe 'esnbootstrap::hostname'

include_recipe 'esnbootstrap::ntp'

include_recipe 'esnspacewalk::client'
