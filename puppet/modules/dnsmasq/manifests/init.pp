# we use dnsmasq to allow wildchar testing for subdomains
# /etc/hosts is too limited
class dnsmasq{
  class{"dnsmasq::packages":} -> class{"dnsmasq::configs": } -> class{"dnsmasq::service":}
}


class dnsmasq::packages{
  package{"dnsmasq": ensure => installed}
}

class dnsmasq::configs{
  # all requests to (*.)dawanda.com will go to 127.0.0.1
  file{"/etc/dnsmasq.d/my_local":
    content => "address=/dawanda.com/127.0.0.1\n",
  }
}

class dnsmasq::service{
  service{"dnsmasq":
    ensure    => running,
    subscribe => Class["dnsmasq::configs"]
  }
}