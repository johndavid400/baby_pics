BabyPics::Application.routes.draw do

  mount Refinery::Core::Engine, :at => '/'

end


Refinery::Core::Engine.routes.draw do

  root :to => 'home#index'

  get "upload_image" => "uploads#upload"
  post "create_image" => "uploads#create_image"

  get "home" => "home#index"

end
