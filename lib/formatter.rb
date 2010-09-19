class Formatter
  def self.htmlize_body string
    parse_logins parse_tags parse_links string

  end
  def self.parse_logins string
    findUsers = /(\^|\@)\w{1,}/
    res = string.gsub(findUsers) do |match|
      '<a href="http://'+match[1..-1]+'.blip.pl">'+match+'</a>'
    end
    return res || string
  end
  def self.parse_links string
    findLinks = /http(s)*:\/\/[0-9a-zA-Z\,\;\_\/\.\-\&\=\?\%]+/
    res = string.gsub(findLinks) do |match|
      '<a href="'+match+'">'+match+'</a>'
    end
    return res || string
  end
  def self.parse_tags string
    findTags = /#[a-zA-Z0-9ęóąśłżźćń_\-]*/
    res = string.gsub(findTags) do |match|
      '<a href="http://blip.pl/tags/'+match[1..-1]+'">'+match+'</a>'
    end
    return res || string
  end
end
