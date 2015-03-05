require './yo.rb'
require './config.rb'
require 'sinatra'
require 'sinatra/reloader' if development?

the_true = Yo.new true_token
the_false = Yo.new false_token
the_exception = Yo.new exception_token

services = [['/true/', the_true], 
            ['/false/', the_false], 
            ['/exception/', the_exception]]

services.each do |pettern, yoer|
  post pettern do
    yoer.yo params['username']
  end
end
