require 'json'
require 'net/http'
require 'uri'

class YoException < Exception; end
class YoNoUserFoundException < YoException; end
class YoNotAUsernameException < YoException; end

class Yo
  def initialize(api_token, host_name='https://api.justyo.co')
    @host = host_name
    @token = api_token
  end
  
  def yo(username)
    res = post_yo_request username
    if res['success']
      res['yo_id']
    elsif res['code'] == 404 then
      raise YoNoUserFoundException
    else
      raise YoException
    end
  end

  def post_yo_request(username)
    raise YoNotAUsernameException if !valid_username?(username)
    url = URI.parse("#{@host}/yo/")
    responce = Net::HTTP.post_form(url, {
      'api_token' => @token,
      'username' => username
    })
    JSON.parse(responce.body)
  end

  def valid_username?(username)
    username.is_a? String
  end
end

