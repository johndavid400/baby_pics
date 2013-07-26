Refinery::Image.class_eval do

  def thumbnail_image
   image.thumb('320x240#c').url
  end

end
