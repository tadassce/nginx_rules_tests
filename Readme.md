# Requirements:

      - Vagrant (http://www.vagrantup.com/)

# Usage:

    $ git clone git://github.com/dawanda/nginx_rules_tests.git
    $ cd nginx_rules_tests
    # start vagrant
    $ vagrant up
    # this will produce failed output, expected
    $ vagrant ssh
    # update package sources
    $ apt-get update
    # run the tests, they shall pass
    $ subdomain_tests


# runpuppet (run  puppet):
    $ runpuppet

# run tests for nginx:
    $ subdomain_tests



# Development:

  [1] Add tests  first:
        in puppet/modules/rewriter/templates/rewriter_test.rb.erb

  [2] Change the NGINX config to make them pass:
        in puppet/modules/nginx/templates/nginx.conf.erb

  [3] run tests:
        subdomain_tests