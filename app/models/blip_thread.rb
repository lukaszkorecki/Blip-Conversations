class BlipThread
  attr_accessor :collection, :more_available
  def initialize(depth = 10)
    @blip_match = /http:\/\/blip.pl\S+/i
    @collection = []
    # this seemst to be the other way around.. oh well :-)
    @depth = depth
    @limit = 0
  end
  def build id
    Rails.logger.info "DEPTH #{@depth} ID: #{id}"
    status = Blip.store_or_retreive id
    @collection = [] if not status and @collection.empty?
    @collection.push status
    if @blip_match =~ status['body'] and @depth > @limit
      build extract_id status["body"]
    end
    if @blip_match =~ status['body'] and @depth == @limit
      @more_available = extract_id status['body']
    end
    @depth -=1
  end
  def extract_id body

      id = body.match(@blip_match)
      id =  id.to_s.split('/').last
  end
end
