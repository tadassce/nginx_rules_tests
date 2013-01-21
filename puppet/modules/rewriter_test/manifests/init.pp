class rewriter_test{
  include rewriter_test::packages
}

class rewriter_test::packages{
  package { ['sinatra', 'minitest', 'json']:
    ensure   => installed,
    provider => 'gem'
  }
}