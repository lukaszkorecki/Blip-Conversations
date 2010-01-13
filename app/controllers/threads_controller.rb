class ThreadsController < ApplicationController
  def index 
  end
  def show
    @collection = []
    @id = params[:id]
     resp = self.build @id
  end
    def build id
      logger.info  "JDI: " + id
      blip = BlipPlApi.new
      status = blip.get_status_by_id id
      logger.info status
      @collection.push status
      if /http:\/\/blip.pl\S+/i =~ status['body']
        id = status['body'].match(/http:\/\/blip.pl\S+/i)
        id =  id.to_s.split('/').last()
        logger.info id
        self.build id
      end
    end
end
