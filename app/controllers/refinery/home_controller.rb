module Refinery
  class HomeController < ::ApplicationController

    def index
      @page = Refinery::Page.find_by_title("Home")
      @per_page_options = ["6", "12", "18", "24", "All"]
      unless session[:per_page].present?
        session[:per_page] = 6
      end
      if params[:per_page].present?
        set_per_page
      end
      get_images
    end

    def get_images
      if session[:per_page] == "All"
        @images = Refinery::Image.order("created_at DESC").paginate(:page => params[:page], :per_page => Refinery::Image.count)
      else
        @images = Refinery::Image.order("created_at DESC").paginate(:page => params[:page], :per_page => session[:per_page])
      end
    end

    def set_per_page
      session[:per_page] = params[:per_page]
    end

  end
end
