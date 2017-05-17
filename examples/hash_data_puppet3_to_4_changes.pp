$hash = {
  'foo'   => {
    uid   => '1234',
    shell => '/bin/bash'
  },
  'bar'   => {
    uid   => '1235',
    home  => '/var/users/home/bar',
    shell => '/sbin/nologin',
  }
}

# Puppet 3
# create_resource('user', $hash)

$hash.each |$key, $value| {
  user { $key:
    * => $value,
  }
}

