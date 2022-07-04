#
# Cookbook:: esnbootstrap
# Recipe:: default
#
# Copyright:: 2022, Andrei Lalla, All Rights Reserved.
#

include_recipe 'esnbootstrap::disable_svcs'
include_recipe 'esnbootstrap::ntp'
include_recipe 'esnbootstrap::os_updates'
