# class: webhook::params
#
# this class manages webhook puppet parameters
#
# parameters:
#
# actions:
#
# requires:
#
# sample usage:
#
class webhook::params {

  # OS specific stuff
  if $::osfamily == 'RedHat' {
    $ruby_dev = 'ruby-devel'
    $gcc_cpp  = 'gcc-c++'
  } elsif $::osfamily == 'Debian' {
    $ruby_dev = 'ruby-dev'
    $gcc_cpp  = 'g++'
  }

}
