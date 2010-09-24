ActionController::Routing::Routes.draw do |map|
  map.root :controller => 'threads', :action => 'index'
  map.connect '/threads', :controller => 'threads', :action => 'index'
  map.connect '/threads/:id', :controller => 'threads', :action => 'show'
  map.connect '/:id', :controller => "threads", :action => "show"
  
end
