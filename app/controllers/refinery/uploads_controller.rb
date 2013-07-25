module Refinery
  class UploadsController < ::ApplicationController

    def upload
      @image = Refinery::Image.new
      @uploaded_image = Refinery::Image.find(params[:image_id]) if params[:image_id]
    end

    def create_image
      @images = []
      begin
        unless params[:image].present? and params[:image][:image].is_a?(Array)
          @images << (@image = ::Refinery::Image.create(params[:image]))
        else
          params[:image][:image].each do |image|
            @images << (@image = ::Refinery::Image.create({:image => image}.merge(params[:image].except(:image))))
          end
        end
      rescue Dragonfly::FunctionManager::UnableToHandle
        logger.warn($!.message)
        @image = ::Refinery::Image.new
      end

      unless params[:insert]
        if @images.all?(&:valid?)
          flash.notice = t('created', :scope => 'refinery.crudify', :what => "'#{@images.map(&:title).join("', '")}'")
          if from_dialog?
            @dialog_successful = true
            render :nothing => true, :layout => true
          else
            # redirect_to refinery.admin_images_path
            redirect_to refinery.upload_image_path(:image_id => @image.id)
          end
        else
          self.new # important for dialogs
          render :action => 'new'
        end
      else
        # if all uploaded images are ok redirect page back to dialog, else show current page with error
        if @images.all?(&:valid?)
          @image_id = @image.id if @image.persisted?
          @image = nil
        end

        self.insert
      end
    end

  end
end
