class FrameController < ApplicationController
before_action :authenticate_user!, only: [:new, :create]

  def index

  end

  def new
    @frame = Frame.new
  end

  def create
    @frame = current_user.frames.create(frame_params)

    if @frame.valid?
      redirect_to root_path
    else 
      render :new, status: :unprocessable_entity
    end
  end

  def show
    @frame = Frame.find_by_id(params[:id])
    return render_not_found if @frame.blank?
  end

  def edit
    @frame = Frame.find_by_id(params[:id])
    return render_not_found if @frame.blank?
  end

  def update
    @frame = Frame.find_by_id(params[:id])
    return render_not_found if @frame.blank?

    @frame.update_attributes(frame_params)
    
    if @frame.valid?
      redirect_to root_path
    else 
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
    @frame = Frame.find_by_id(params[:id])
    return render_not_found if @frame.blank?

    @frame.destroy
    redirect_to root_path
  end

  private

  def frame_params
    params.require(:frame).permit(:message)
  end

  def render_not_found
    render plain: 'Not Found :(', status: :not_found
  end


end
