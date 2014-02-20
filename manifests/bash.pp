class userprefs::bash (
  $default  = true,
  $password = undef,
) {
  package { 'bash':
    ensure => present,
  }

  file { '/root/.bashrc':
    ensure  => file,
    replace => false,
    source  => 'puppet:///modules/userprefs/shell/bashrc',
    require => Package['bash'],
  }

  file { '/root/.bash_profile':
    ensure  => file,
    replace => false,
    source  => 'puppet:///modules/userprefs/shell/bash_profile',
    require => File['/root/.bashrc'],
  }

  if $default {
    user { 'root':
      ensure   => present,
      shell    => '/bin/bash',
      password => $password,
      require  => Package['bash'],
    }
  }
}
