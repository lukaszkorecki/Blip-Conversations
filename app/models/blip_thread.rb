class BlipThread
  attr_accessor :collection, :more_available
  def initialize(depth = 10)
    @collection = []
    @blip ||= BlipPlApi.new
    # this seemst to be the other way around.. oh well :-)
    @depth = depth
    @limit = 0
  end
  def build id
    puts "DEPTH #{@depth}"
    Rails.logger.info id
    status = @blip.get_status_by_id id
    @collection = [] if not status and @collection.empty?
    @collection.push status
    if /http:\/\/blip.pl\S+/i =~ status['body'] and @depth > @limit
      build extract_id status["body"]
    end
    if /http:\/\/blip.pl\S+/i =~ status['body'] and @depth == @limit
      @more_available = extract_id status['body']
    end
    @depth -=1
  end
  def extract_id body

      id = body.match(/http:\/\/blip.pl\S+/i)
      id =  id.to_s.split('/').last
  end
end
