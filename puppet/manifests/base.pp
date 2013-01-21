# basics
group { "puppet":
  ensure => "present",
}

File { owner => 0, group => 0, mode => 0644 }


package{"tmux": ensure => installed}

# a helper script to run puppet
file{"/usr/local/bin/runpuppet":
  content => "sudo puppet apply -vv  --modulepath=/tmp/vagrant-puppet/modules-0/ /tmp/vagrant-puppet/manifests/base.pp\n",
  mode    => 0755
}

# nginx with configs, we'd like to test
include nginx

# allow testing dawanda.com with wildchar
include dnsmasq
