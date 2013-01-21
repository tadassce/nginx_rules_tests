class dnsmasq{
  package{"dnsmasq": ensure => installed}

  file{"/etc/dnsmasq.d/my_local":
    content => "address=/dawanda.com/127.0.0.1\n",
    require => Package["dnsmasq"]
  }
}