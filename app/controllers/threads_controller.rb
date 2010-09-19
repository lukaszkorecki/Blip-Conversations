class ThreadsController < ApplicationController
  def index
    unless params[:id].nil?
      redirect_to  '/threads/'+params[:id]
    end
  end
  def show
    @blip_thread ||=  BlipThread.new(10)
    @id = extract_id_from_url params[:id]
    @blip_thread.build(params[:id])
    @collection = @blip_thread.collection
    render 'empty' if @collection.empty?
    render('show', :layout => false ) if request.xhr?
  end
  private
    def extract_id_from_url id
      return id if id.to_i > 0
      if id =~ /^http:\/\/blip.pl/
        id.split("/").last
      end
    end
end
