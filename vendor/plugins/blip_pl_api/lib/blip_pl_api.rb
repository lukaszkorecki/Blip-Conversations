# BlipPlApi
class BlipPlApi
  attr_reader :api_root
  def initialize
    @api_root = 'http://api.blip.pl'
  end
  def get_request( path)
    require 'net/http'
    require 'uri'
    res = Net::HTTP.get_response(URI.parse(@api_root + path))
    res.inspect
    res.body
  end
  def get_status_by_id(id)
    self.get_request('/updates/'+id.to_s)
  end
end
