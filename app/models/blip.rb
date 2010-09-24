class Blip < ActiveRecord::Base
  def store_or_retreive status
    b = find_by_id(status["id"])
    b = create(
        :blip_id => status["id"],
        :body => status["body"],
        :user => status["user"]["login"],
        :blip_created => status["created_at"],
        :avatar => status["user"]["avatar"]["url_30"]) if b.nil?
    to_hash b
  end
  def to_hash record
    {
      'id' => b.blip_id,
      'user'=> {
        'login' => b.user,
        'avatar' => {
          "url_30" => status[:avatar]
        }
      },
      'body' => b.body,
      "created_at" => status[:blip_created]
    }
  end
end
