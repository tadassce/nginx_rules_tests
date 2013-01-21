require 'sinatra/base'
require 'json'

class EnvApp < Sinatra::Base

 get '*' do
   keys =  (request.env.keys.grep(/REQ/) + request.env.keys.grep(/PATH/))
   r = {}
   keys.each {|k| r[k] = request.env[k]}
   JSON.unparse(r)
 end
end
