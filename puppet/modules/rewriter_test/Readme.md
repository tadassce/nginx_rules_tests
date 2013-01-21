# The nginx tests + a small app for tests

# run sinatra app for tests
cd /tmp/vagrant-puppet/modules-0/rewriter_test/templates && nohup rackup &

# run tests for nginx:
cd /tmp/vagrant-puppet/modules-0/rewriter_test/templates
runpuppet && ruby rewriter_test.rb.erb
