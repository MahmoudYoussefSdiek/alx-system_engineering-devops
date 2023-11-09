# Create a new configuration file for Apache
file { '/etc/apache2/conf-available/debug.conf':
  content => "LogLevel debug\n",
}

# Enable the new configuration file
exec { 'enable-debug-conf':
  command => 'a2enconf debug',
  path    => '/usr/sbin:/usr/bin:/sbin:/bin',
  creates => '/etc/apache2/conf-enabled/debug.conf',
}

# Restart Apache to apply the new configuration
service { 'apache2':
  ensure    => 'running',
  subscribe => File['/etc/apache2/conf-available/debug.conf'],
}

# Trace the Apache process with strace
exec { 'trace-apache':
  command     => 'strace -f -o /tmp/apache.strace -p $(pgrep apache2)',
  path        => '/usr/sbin:/usr/bin:/sbin:/bin',
  refreshonly => true,
}
