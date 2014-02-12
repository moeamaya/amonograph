class HomeController < ApplicationController
  respond_to :js, :html

  def index
    @drawings = Drawing.order("created_at DESC").paginate(:page => params[:page])
  end
end
