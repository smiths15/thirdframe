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

    if @frame.blank?
      render plain: 'Not Found :(', status: :not_found
    end



  end

  private

  def frame_params
    params.require(:frame).permit(:message)
  end


end
