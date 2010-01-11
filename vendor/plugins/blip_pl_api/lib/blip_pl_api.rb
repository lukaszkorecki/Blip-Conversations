require 'net/http'
require 'uri'
# BlipPlApi
class BlipPlApi
  attr_accessor :api_root
  @@api_root = 'http://api.blip.pl'
  def send_request(path)
    url= URI.parse(@@api_root + path.join('/'))
    res = HTTP.get_print(url)
  end
 
  
  def get_status_by_id(id)
    self.send_request(:get, { :updates => id})
  end
end
