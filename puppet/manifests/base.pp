# basics
group { "puppet":
  ensure => "present",
}

Exec { path => [ "/bin/", "/sbin/" , "/usr/bin/", "/usr/sbin/" ] }
File { owner => 0, group => 0, mode => 0644 }

stage { 'first':
  before => Stage['main'],
}
stage { 'last': }
Stage['main'] -> Stage['last']

package{"tmux": ensure => installed}
package{"curl": ensure => installed}

# a helper script to run puppet
file{"/usr/local/bin/runpuppet":
  content => "sudo puppet apply -vv  --modulepath=/tmp/vagrant-puppet/modules-0/ /tmp/vagrant-puppet/manifests/base.pp\n",
  mode    => 0755
}

file{"/usr/local/bin/nginx_tests":
  content => "
    cd /vagrant/nginx_tests && \
    runpuppet && \
    sudo /etc/init.d/nginx restart && \
    sudo /etc/init.d/dnsmasq restart && \
    ruby nginx_test.rb",
  mode    => 0755
}

class update_aptget{
  exec{"apt-get update && touch /tmp/apt-get-updated":
    unless => "test -e /tmp/apt-get-updated"
  }
}

# run this first
class {'update_aptget':
  stage => first,
}

class{'nginx':}
class{"rewriter_test":}


class {'dnsmasq':
  stage => last,
}