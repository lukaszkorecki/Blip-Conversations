class BlipThread
  attr_accessor :collection
  def initialize(depth = 10)
    @collection = []
    @blip ||= BlipPlApi.new
    @depth = depth
  end
  def build id
    puts "DEPTH #{@depth}"
    Rails.logger.info id
    status = @blip.get_status_by_id id
    @collection = [] if not status and @collection.empty?
    @collection.push status
    @depth -=1
    if /http:\/\/blip.pl\S+/i =~ status['body']
      id = status['body'].match(/http:\/\/blip.pl\S+/i)
      id =  id.to_s.split('/').last
      build id
    end
  end
end
