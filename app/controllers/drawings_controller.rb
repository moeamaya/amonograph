class DrawingsController < ApplicationController
  before_filter :authorize, only: [:upload]

  def show
    id = params[:id]
    plus = id.to_i + 1
    puts plus

    @drawing = Drawing.find(id)
    link = Drawing.find_by_id(plus)
    @next = link ? link : Drawing.first

  end

  def create
    @drawing = Drawing.create(drawing_params)

    respond_to do |format|
      if @drawing.save
        format.html { redirect_to root_path, notice: 'Note was successfully created.' }
        format.json { render json: @drawing, status: :created, location: @drawing }
      else
        format.html { render action: "upload" }
        format.json { render json: @drawing.errors, status: :unprocessable_entity }
      end
    end
  end

  def upload
    @drawing = Drawing.new()
  end

  private

  def drawing_params
    params.require(:drawing).permit(:title, :about, :drawing, :views)
  end

  def authorize
    redirect_to root_path, alert: "Not authorized" if current_user.nil?
  end
end
