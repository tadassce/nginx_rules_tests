# basics
group { "puppet":
  ensure => "present",
}

File { owner => 0, group => 0, mode => 0644 }

file { '/etc/motd':
  content => "Welcome to your Vagrant-built virtual machine!
              Managed by Puppet.\n"
}


#package{"nginx": ensure => installed}
package{"dnsmasq": ensure => installed}

# allow testin dawanda.com with wildchar
file{"/etc/dnsmasq.d/my_local":
  content => "address=/dawanda.com/127.0.0.1\n",
  require => Package["dnsmasq"]
}

include nginx