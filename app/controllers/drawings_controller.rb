class DrawingsController < ApplicationController
  before_filter :authorize, only: [:new, :edit, :create, :update]
  impressionist :actions => [:show, :unique => [:impressionable_type, :impressionable_id, :session_hash]]

  before_filter :first_time?, only: [:show]
  #before_action :authenticate_user!, except: [:show]

  def show
    id = params[:id]

    @drawing = Drawing.find(id)
    @prev = Drawing.prev(id.to_i)
  end

  def new
    @drawing = Drawing.new()
  end

  def create
    @drawing = current_user.drawings.create(drawing_params)

    respond_to do |format|
      if @drawing.save
        format.html { redirect_to root_path, notice: 'Drawing was successfully uploaded.' }
        format.json { render json: @drawing, status: :created, location: @drawing }
      else
        format.html { render action: "new" }
        format.json { render json: @drawing.errors, status: :unprocessable_entity }
      end
    end
  end

  def edit
    @drawing = Drawing.find(params[:id])
  end

  def update
    @drawing = Drawing.find(params[:id])
    if @drawing.update_attributes(drawing_params)
       flash[:success] = "Drawing updated successfully!"
       redirect_to root_path
    else
      render 'edit'
    end
  end


  private

  def drawing_params
    params.require(:drawing).permit(:title, :about, :drawing, :views, :original_file)
  end

  def authorize
    redirect_to login_path, alert: "Login first" if current_user.nil?
  end

  def first_time?
    if cookies.permanent[:first_time].nil?
      @first_time = true
      cookies.permanent[:first_time] = 1
    else
      @first_time = false
    end
  end
end
