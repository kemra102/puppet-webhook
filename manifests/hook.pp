define webhook::hook (
  $port      = '80',
  $params    = [],
  $cmd       = undef,
  $cmd_param = undef,
) {

  File {
    owner => 'root',
    group => 'root',
  }

  file { "/var/www/${name}":
    ensure => 'directory',
    mode   => '0755',
  }
  file { "/var/www/${name}/config.ru":
    ensure  => 'file',
    mode    => '0644',
    source  => 'puppet:///modules/webhook/config.ru',
    require => File["/var/www/${name}"],
  }
  file { "/var/www/${name}/Gemfile":
    ensure  => 'file',
    mode    => '0644',
    source  => 'puppet:///modules/webhook/Gemfile',
    require => File["/var/www/${name}"],
  }
  file { "/var/www/${name}/webhook.rb":
    ensure  => 'file',
    mode    => '0644',
    content => template('webhook/webhook.rb'),
    require => File["/var/www/${name}"],
  }
  file { "/etc/init.d/webhook-${name}":
    ensure  => 'file',
    mode    => '0755',
    content => template("webhook/service.${::osfamily}.erb"),
  }

  bundler::install { "/var/www/${name}":
    user       => 'root',
    group      => 'root',
    deployment => false,
    without    => 'development test doc',
    require    => [
      File["/var/www/${name}/config.ru"],
      File["/var/www/${name}/Gemfile"],
      Package["${::webhook::ruby_dev}"],
    ],
  }

  service { "webhook-${name}":
    ensure     => 'running',
    enable     => true,
    hasstatus  => true,
    hasrestart => true,
    require    => [
      Bundler::Install["/var/www/${name}"],
      File["/var/www/${name}/webhook.rb"],
    ],
  }

}
