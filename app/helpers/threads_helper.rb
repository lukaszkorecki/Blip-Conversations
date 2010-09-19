module ThreadsHelper
  def parse_blip_body body
    Formatter.htmlize_body body
  end

end
