class Blip < ActiveRecord::Base
  def self.build id
    blip = BlipPlApi.new
    status = blip.get_status_by_id id
    return false unless status
    @collection.push status
    if /http:\/\/blip.pl\S+/i =~ status['body']
      id = status['body'].match(/http:\/\/blip.pl\S+/i)
#      id = status['body'].scan(/http:\/\/blip.pl\S+/i)
      id =  id.to_s.split('/').last()
      self.build id
    end
  end
end
