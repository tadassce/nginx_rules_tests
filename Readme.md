# Requirements:

      - Vagrant (http://www.vagrantup.com/)

# Usage:

    $ git clone git://github.com/dawanda/nginx_rules_tests.git
    $ cd nginx_rules_tests

    # start vagrant
    $ vagrant up

    # ssh into your VM
    $ vagrant ssh

    # run the tests, they shall pass
    $ nginx_tests


# runpuppet (run  puppet):
    $ runpuppet

# run tests for nginx:
    $ nginx_tests



# Development:

  [1] Add tests  first:

        in nginx_tests/nginx_test.rb

  [2] Change the NGINX config to make them pass:

        in puppet/modules/nginx/templates/nginx.conf.erb

  [3] run tests:

        nginx_tests