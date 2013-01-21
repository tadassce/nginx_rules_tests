# basics
group { "puppet":
  ensure => "present",
}

File { owner => 0, group => 0, mode => 0644 }


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

# dnsmasq: testing dawanda.com with wildchar
# nginx: with configs, we'd like to test
#
class {'dnsmasq':} -> class{'nginx':} -> class{"rewriter_test":}

