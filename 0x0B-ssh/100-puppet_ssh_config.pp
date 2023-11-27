# ssh_config.pp

file { '/home/ubuntu/.ssh/config':
  ensure  => present,
  content => "Host 54.89.134.42
              IdentityFile ~/.ssh/school
              PasswordAuthentication no\n",
  owner   => 'ubuntu',
  group   => 'ubuntu',
  mode    => '0600',
}
