BabyPics::Application.routes.draw do

  mount Refinery::Core::Engine, :at => '/'

end


Refinery::Core::Engine.routes.draw do

  get "upload_image" => "uploads#upload"
  post "create_image" => "uploads#create_image"

end
