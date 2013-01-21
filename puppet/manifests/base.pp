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
package{"tmux": ensure => installed}

# allow testin dawanda.com with wildchar
file{"/etc/dnsmasq.d/my_local":
  content => "address=/dawanda.com/127.0.0.1\n",
  require => Package["dnsmasq"]
}

file{"/usr/local/bin/runpuppet":
  content => "sudo puppet apply -vv  --modulepath=/tmp/vagrant-puppet/modules-0/ /tmp/vagrant-puppet/manifests/base.pp\n",
  mode    => 0755
}

include nginx