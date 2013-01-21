# we use dnsmasq to allow wildchar testing for subdomains
# /etc/hosts is too limited
class dnsmasq{
  package{"dnsmasq": ensure => installed}

  # all requests to (*.)dawanda.com will go to 127.0.0.1
  file{"/etc/dnsmasq.d/my_local":
    content => "address=/dawanda.com/127.0.0.1\n",
    require => Package["dnsmasq"]
  }
}
