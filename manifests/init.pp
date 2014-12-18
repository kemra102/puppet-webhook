class webhook (
  $ruby_dev        = $webhook::params::ruby_dev,
) inherits webhook::params {

  if ! defined(Package[$ruby_dev]) {
    package { $ruby_dev:
      ensure  => 'installed',
      require => Package[$gcc_cpp],
    }
  }

  package { $gcc_cpp:
    ensure => 'installed',
  }

}
