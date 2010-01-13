# BlipPlApi
require 'net/http'
require 'uri'
require 'json'
class BlipPlApi
  attr_reader :api_root, :headers,:include_string, :query_params
  def initialize
    @api_root = 'http://api.blip.pl'
    @query_params = {
      :include =>'users,users[avatar],recipients,recipients[avatar],pictures'
    }
    @headers = {
      'Accept'=>'application/json',
      'User-Agent' => 'Blip Conversations',
      'X-Blip-Api'=> '0.02'
    }
  end
  def get_request path
    url = URI.parse @api_root+path
    req = Net::HTTP::Get.new url.path

    req.set_form_data @query_params
    req = Net::HTTP::Get.new(url.path+'?'+req.body)

    @headers.each {  |k,v| req.add_field k, v }
    res = Net::HTTP.start(url.host, url.port) { |http|
      http.request req
    }
    JSON.parse res.body
  end
  def get_status_by_id id
    self.get_request '/statuses/'+id.to_s
  end
end
