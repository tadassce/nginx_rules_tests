# run puppet with

# runpuppet
sudo puppet apply -vv  --modulepath=/tmp/vagrant-puppet/modules-0/ /tmp/vagrant-puppet/manifests/base.pp


$ tmux

# run sinatra app for tests
cd /tmp/vagrant-puppet/modules-0/rewriter_test/templates
rackup

# run tests for nginx:
cd /tmp/vagrant-puppet/modules-0/rewriter_test/templates
runpuppet && ruby rewriter_test.rb.erb
