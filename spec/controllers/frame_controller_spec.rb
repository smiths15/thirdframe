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
    it "should successfully create the new post on form" do
      post :create
      expect(response).to have_http_status(:success)
    end
  end








end
