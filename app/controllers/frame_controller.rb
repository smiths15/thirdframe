class FrameController < ApplicationController
#before_action :authenticate_user!

  def index

  end

  def new
    @frame = Frame.new
  end

  def create
    @frame = Frame.create(frame_params)

    if @frame.valid?
      redirect_to root_path
    else 
      render :new, status: :unprocessable_entity
    end
  
  end

  private

  def frame_params
    params.require(:frame).permit(:message)
  end


end
