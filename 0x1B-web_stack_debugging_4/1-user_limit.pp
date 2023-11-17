# 1-user_limit.pp

# Increase the file limit for the holberton user
exec { 'change-os-configuration-for-holberton-user':
  command => 'echo "holberton soft nofile 65535" >> /etc/security/limits.conf',
  unless  => 'grep -q "holberton soft nofile 65535" /etc/security/limits.conf',
  path    => '/bin:/usr/bin',
  require => Package['puppet'],
}

# Apply the changes to the holberton user
exec { 'apply-os-configuration-for-holberton-user':
  command => 'sysctl -p',
  path    => '/sbin:/usr/sbin:/bin:/usr/bin',
  require => Exec['change-os-configuration-for-holberton-user'],
}
