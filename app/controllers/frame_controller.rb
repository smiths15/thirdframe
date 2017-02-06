class FrameController < ApplicationController
before_action :authenticate_user!

  def index

  end

  def new
  @frame = Frame.new
  end

  def create
    @frame = Frame.create(frame_params)
    redirect_to root_path
  end

  private

  def frame_params
    params.require(:frame).permit(:message)
  end

end
