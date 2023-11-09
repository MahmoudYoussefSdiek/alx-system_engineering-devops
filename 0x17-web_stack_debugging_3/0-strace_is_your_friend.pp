# Trace the Apache process with strace
exec { 'trace-apache':
  command     => 'strace -f -o /tmp/apache.strace -p $(pgrep apache2)',
  path        => '/usr/sbin:/usr/bin:/sbin:/bin',
  refreshonly => true,
}
