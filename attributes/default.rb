default['realm']['packages'] = %w(realmd sssd oddjob oddjob-mkhomedir adcli samba-common-tools)

default['realm']['join'] = true

default['realm']['sssd_actions'] = [:enable]

default['realm']['sssd_path'] = '/ect/sssd'
default['realm']['sssd_domain'] = 'myxingfu.net'
default['realm']['use_fqdn'] = false

