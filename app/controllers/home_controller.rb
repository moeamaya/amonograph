class HomeController < ApplicationController
  respond_to :js, :html

  def index
    #@gallery = Drawing.limit(4).order("created_at DESC")
    @drawings = Drawing.order("created_at DESC").paginate(:page => params[:page])
    @drawing = Drawing.new()
  end
end
