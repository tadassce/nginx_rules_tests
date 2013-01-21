class nginx{
  include nginx::packages
  include nginx::configs
  include nginx::service
  Class['nginx::packages'] -> Class['nginx::configs']-> Class['nginx::service']
}

class nginx::packages{
  package { "nginx":
    ensure => installed,
  }
}

class nginx::configs{
  file{"/etc/nginx/nginx.conf":
    content => template("nginx/nginx.conf.erb")
  }
}

class nginx::service{
  service{"nginx":
    ensure    => running,
    subscribe => Class["nginx::configs"]
  }
}