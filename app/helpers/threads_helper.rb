module ThreadsHelper
  def parse_blip_body body
    body.gsub! /http:\S+/, '<a href=\0>\0</a>'
    body.gsub! /\^\W+/, '<a href="http://blip.pl/"\0>\0</a>'
    body.gsub! /\#\W+/, '<a href="http://blip.pl/tags/\0">\0</a>'
    return body
  end

end
