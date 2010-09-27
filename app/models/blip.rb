class Blip < ActiveRecord::Base
  def self.store_or_retreive id
    @blip ||= BlipPlApi.new
    b = find_by_blip_id(id)
    unless b
      status = @blip.get_status_by_id id
      create(
        :blip_id => id,
        :json => status.to_json
      ) if status
      b=nil
    end
    return b ? JSON.parse(b.json) : status
  end
end
