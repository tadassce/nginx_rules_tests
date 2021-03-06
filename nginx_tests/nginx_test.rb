require 'open-uri'
require 'rubygems'
require 'minitest/autorun'
require 'json'


# run test-app before!
# returns as hash:
#  ["REQUEST_PATH", "REQUEST_URI", "REQUEST_METHOD", "REQUEST_PATH", "PATH_INFO"]

class AppStarter
  def self.start_app
    @test_app ||= begin
      app_pid = IO.popen("rackup 2>&1 >> /dev/null")
      sleep 0.5
      app_pid
    end
  end

  def self.kill_app
    `sudo pkill -9 -f rackup`
  end
end

MiniTest::Unit.after_tests() { AppStarter.kill_app }

LANGUAGES = %w(de en fr pl nl es it)
describe "testing" do
  before do
    AppStarter.start_app
  end

  def make_request(url)
    r = `curl -s '#{url}'`
    JSON.parse(r) rescue r
  end

  def make_request_for_headers(url)
    r = `curl -s --head #{url}`
  end

  def check_request_uri(url)
    r = make_request(url)
    remove_port(r["REQUEST_URI"].gsub("http://", ''))
  end

  def remove_port(url)
    url.gsub(/\:9292/, '')
  end

  describe "subdomains" do
    describe "lang" do
      LANGUAGES.each do |lng|
        it "passes language #{lng} through" do
          check_request_uri("#{lng}.dawanda.com").must_equal "#{lng}.dawanda.com/"
        end
      end

      it "defaults to 'de' lang" do
        check_request_uri("dawanda.com").must_equal "de.dawanda.com/"
      end
    end

    describe "shop subdomains" do
      it "works" do
        make_request("meko.dawanda.com").must_match "301 Moved"
        make_request_for_headers("meko.dawanda.com").must_match "de.dawanda.com/shop/meko"
      end
    end

    describe "www is redirected" do
      it "works" do
        make_request("www.dawanda.com/shop/Meko/first").must_match "301 Moved"
      end
    end
  end

  describe "path" do
    it "is left untouched" do
      check_request_uri("de.dawanda.com/shop/Meko/first").must_equal "de.dawanda.com/shop/Meko/first"
    end
  end

  describe "params" do
    it "is left untouched" do
      check_request_uri("de.dawanda.com/shop/Meko/first?a=1").must_equal "de.dawanda.com/shop/Meko/first?a=1"
    end
  end
end
