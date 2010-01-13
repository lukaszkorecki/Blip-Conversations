class ThreadsController < ApplicationController
before_filter :respond_to_ajax
  def index 
    unless params[:id].nil?
      redirect_to  '/threads/'+params[:id]
    end
  end
  def show
    @collection = []
    @id = params[:id]
    resp = self.build @id
   #render 'empty' if resp == false
    respond_to do |format| 
      format.html
      format.json { render :json => @collection.to_json}
    end
  end
    def build id
      blip = BlipPlApi.new
      status = blip.get_status_by_id id

      return false unless status

      @collection.push status
      if /http:\/\/blip.pl\S+/i =~ status['body']
        id = status['body'].match(/http:\/\/blip.pl\S+/i)
        id =  id.to_s.split('/').last()
        self.build id
      end
    end
    def respond_to_ajax
      request.format = :json if request.xhr?
    end
end
