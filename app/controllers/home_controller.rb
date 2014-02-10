class HomeController < ApplicationController
  def index
    @gallery = Drawing.all()

    @drawing = Drawing.new()
  end
end
