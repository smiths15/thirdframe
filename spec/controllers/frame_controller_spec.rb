require 'rails_helper'

RSpec.describe FrameController, type: :controller do
  describe "frame#index action" do
    it "should successfully show the page" do
      get :index
      expect(response).to have_http_status(:success)
    end
  end


  describe "frame#new action" do
    it "should successfully show the new form" do
      get :new
      expect(response).to have_http_status(:success)
    end
  end

  describe "frame#create action" do
    it "should successfully create a new frame in our database" do
      post :create, params: { frame: {message: 'Hello!'}}
      expect(response).to redirect_to root_path

      frame = Frame.last
      expect(frame.message).to eq('Hello!') 
    end
  end








end
