require 'json'
require 'simplehttp'
  require 'pp'
class BlipPlApi
  attr_reader :api_root, :headers,:include_string, :query_params
  def initialize
    @api_root = 'http://api.blip.pl'
    @query_params = '?include=user,user[avatar],recipient,recipient[avatar],pictures'
    @headers = {
      'Accept'=>'application/json',
      'User-Agent' => 'Blip Conversations',
      'X-Blip-Api'=> '0.02'
    }
  end
  def get_request path
    parsed = URI.escape @api_root+path+@query_params
    conn = SimpleHttp.new(parsed)
    @headers.each  { |k,v| conn.request_headers[k] = v }

    resp = conn.get

    if conn.response_headers['status'] == '200'
      return JSON.parse resp 
    else
      return false
    end

  end
  def get_status_by_id id
    self.get_request '/statuses/'+id.to_s
  end
end
