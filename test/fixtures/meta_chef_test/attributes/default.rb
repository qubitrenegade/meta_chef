default['meta_chef'] = {
  chef_config: {
    chef_client_systemd_timer: {
      interval: '30min',
      splay: '5min',
      accept_chef_license: true,
      action: :add,
    },
    chef_client_config: {
      chef_license: 'accept',
      log_location: :syslog,
      chef_server_url: Chef::Config[:chef_server_url],
      ssl_verify_mode: :verify_none,
      action: :create,
    },
    file: {
      path: '/etc/chef/test_file',
      content: 'This is some text in a file',
      mode: '0755',
      owner: 'root',
      group: 'root',
      action: :create,
    },
  },
  another_app: {
    file: [
      {
        path: '/tmp/super_secret',
        content: 'super secret stuff',
        mode: '0755',
        owner: 'nobody',
        action: :create,
      },
      {
        path: '/tmp/super_secret2',
        content: 'more secret stuff',
        action: :create,
      },
    ],
  },
}
