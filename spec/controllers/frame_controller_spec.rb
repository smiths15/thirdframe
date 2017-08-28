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

      post :create, params: { 
        frame: { 
          message: 'Hello!',
          picture: fixture_file_upload("/picture.png", 'image/png')
        }
      }
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

  describe "frame#edit action" do
    it "shouldn't let a user who did not create the frame edit a frame" do
      frame = FactoryGirl.create(:frame)
      user = FactoryGirl.create(:user)
      sign_in user
      get :edit, params: {id: frame.id}
      expect(response).to have_http_status(:forbidden)
    end

    it "shouldn't let unauthenticatioed users edit a frame" do
      frame = FactoryGirl.create(:frame)
      get :edit, params: {id: frame.id}
      expect(response).to redirect_to new_user_session_path
    end

    it "should successfully show the edit form if the frame is found" do
      frame = FactoryGirl.create(:frame)
      sign_in frame.user
      get :edit, params: { id: frame.id}
      expect(response).to have_http_status(:success)
    end

    it "should return a 404 error if the frame is not found" do
      frame = FactoryGirl.create(:frame)
      sign_in frame.user
      get :edit, params: { id: 'TACOCAT'}
      expect(response).to have_http_status(:not_found)
    end
  end

  describe "frame#update action" do
    it "shouldn't let a user who did not create the frame update a frame" do
      frame = FactoryGirl.create(:frame)
      user = FactoryGirl.create(:user)
      sign_in user
      patch :update, params: {id: frame.id, frame: {message: "wahoo"}}
      expect(response).to have_http_status(:forbidden)
    end

    it "shouldn't let unauthenticatioed users update a frame" do
      frame = FactoryGirl.create(:frame)
      patch :update, params: {id: frame.id, frame: {message: "Hello"}}
      expect(response).to redirect_to new_user_session_path
    end

    it "should allow users to successfully update frames" do
      frame = FactoryGirl.create(:frame, message: "Initial Value")
      sign_in frame.user
      patch :update, params: { id: frame.id, frame: {message: "Changed"}}
      expect(response).to redirect_to root_path
      frame.reload
      expect(frame.message).to eq "Changed"  
    end

    it "should have http 404 error if the frame is not found" do
      frame = FactoryGirl.create(:frame, message: "Initial Value")
      sign_in frame.user
      patch :update, params: { id: "YOLOSWAG", frame: {message: "Changed"}}
      expect(response).to have_http_status(:not_found)
    end

    it "should render the edit form with an http status of unprocessable_entity" do
      frame = FactoryGirl.create(:frame, message: "Initial Value")
      sign_in frame.user
      patch :update, params: { id: frame.id, frame: {message: ""}}
      expect(response).to have_http_status(:unprocessable_entity)
      frame.reload
      expect(frame.message).to eq "Initial Value"
    end
  end

  describe "frame#destroy action" do
    it "shouldn't let a user who did not create the frame destroy a frame" do
      frame = FactoryGirl.create(:frame)
      user = FactoryGirl.create(:user)
      sign_in user
      delete :destroy, params: {id: frame.id}
      expect(response).to have_http_status(:forbidden)
    end

    it "shouldn't let unauthenticatioed users destroy a frame" do
      frame = FactoryGirl.create(:frame)
      delete :destroy, params: {id: frame.id}
      expect(response).to redirect_to new_user_session_path
    end

    it "should allow user to destroy frame" do
      frame = FactoryGirl.create(:frame)
      sign_in frame.user
      delete :destroy, params: {id: frame.id}
      expect(response).to redirect_to root_path
      frame = Frame.find_by_id(frame.id)
      expect(frame).to eq nil
    end

    it "should return a 404 message if we cannot find a frame with the id that is specified" do
      frame = FactoryGirl.create(:frame)
      sign_in frame.user
      delete :destroy, params: {id: "Sapceduck"}
      expect(response).to have_http_status(:not_found)
    end
  end




end
