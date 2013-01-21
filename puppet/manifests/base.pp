# basics
group { "puppet":
  ensure => "present",
}

File { owner => 0, group => 0, mode => 0644 }




package{"tmux": ensure => installed}
file{"/usr/local/bin/runpuppet":
  content => "sudo puppet apply -vv  --modulepath=/tmp/vagrant-puppet/modules-0/ /tmp/vagrant-puppet/manifests/base.pp\n",
  mode    => 0755
}

include nginx
include dnsmasq # allow testing dawanda.com with wildchar
