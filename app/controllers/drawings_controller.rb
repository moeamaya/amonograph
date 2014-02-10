class DrawingsController < ApplicationController
  def show
    @drawing = Drawing.find(params[:id])
  end

  def create
    @drawing = Drawing.create(drawing_params)

    respond_to do |format|
      if @drawing.save
        format.html { redirect_to root_path, notice: 'Note was successfully created.' }
        format.json { render json: @darwing, status: :created, location: @drawing }
      else
        format.html { render action: "new" }
        format.json { render json: @note.errors, status: :unprocessable_entity }
      end
    end
  end

  private

  def drawing_params
    params.require(:drawing).permit(:title, :about, :drawing, :views)
  end
end
