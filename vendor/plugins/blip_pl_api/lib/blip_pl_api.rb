require 'json'
require 'simplehttp'
  require 'pp'
class BlipPlApi
  attr_reader :api_root, :headers,:include_string, :query_params
  def initialize
    @api_root = 'http://api.blip.pl'
    @query_params = '?include=users,users[avatar],recipients,recipients[avatar],pictures'
    @headers = {
      'Accept'=>'application/json',
      'User-Agent' => 'Blip Conversations',
      'X-Blip-Api'=> '0.02'
    }
  end
  def get_request path
    url_str =@api_root+path+@query_params
    conn = SimpleHttp.new(url_str)
    @headers.each  { |k,v| conn.request_headers[k] = v }
# TODO make it error resistant
    resp = conn.get
    if conn.response_headers['status'] == 200
      return JSON.parse resp 
    else
      return false
    end

  end
  def get_status_by_id id
    self.get_request '/statuses/'+id.to_s
  end
end
