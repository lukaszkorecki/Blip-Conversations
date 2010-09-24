class Blip < ActiveRecord::Base
  def store_or_retreive status
    b = find_by_id(status["id"])
    unless b
      create(
        :blip_id => status["id"],
        :body => status["body"],
        :user => status["user"]["login"]
      )
      save!
    end
  end
end
