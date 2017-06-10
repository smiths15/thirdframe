require 'rails_helper'

RSpec.describe FrameController, type: :controller do
  
  describe "frame#index action" do
    it "should successfully show the page" do
      get :index
      expect(response).to have_http_status(:success)
    end
  end 


  describe "frame#new action" do
    it "should require users to be logged in" do  
      get :new

      expect(response).to redirect_to new_user_session_path
    end   

    it "should successfully show the new form" do
      user = FactoryGirl.create(:user)
      sign_in user 

      get :new
      expect(response).to have_http_status(:success)
    end
  end

  describe "frame#create action" do

    it "should require users to be logged in" do  
      post :create, params: { frame: {message: "Hello!"}}

      expect(response).to redirect_to new_user_session_path
    end  

    it "should successfully create a new frame in our database" do

      user = FactoryGirl.create(:user)
      sign_in user 

      post :create, params: { frame: { message: 'Hello!'} }
      expect(response).to redirect_to root_path

      frame = Frame.last
      expect(frame.message).to eq("Hello!")
      expect(frame.user).to eq(user)


    end

    it "should should properly deal with validation errors" do

      user = FactoryGirl.create(:user)
      sign_in user 

      post :create, params: { frame: { message: ''} }
      expect(response).to have_http_status(:unprocessable_entity)
      expect(Frame.count).to eq 0
    end

  end

  describe "frame#show action" do
    it "should successfully show the page if the frame is found" do
      frame = FactoryGirl.create(:frame)
      get :show, params: { id: frame.id}
      expect(response).to have_http_status(:success)
    end

    it "should return a 404 error if the frame is not found" do
      frame = FactoryGirl.create(:frame)
      get :show, params: { id: 'TACOCAT'}
      expect(response).to have_http_status(:not_found)
    end
  

  end



end
