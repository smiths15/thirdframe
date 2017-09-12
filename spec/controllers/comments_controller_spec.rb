require 'rails_helper'

RSpec.describe CommentsController, type: :controller do
  describe "comments#create action" do
    it "should allow users to create comments on frame" do
      frame = FactoryGirl.create(:frame)

      user = FactoryGirl.create(:user)

      sign_in user

      post :create, params: {frame_id: frame.id, comment: {message:'awesome frame'}}

      expect(response).to redirect_to root_path
      expect(frame.comments.first.message).to eq "awesome frame"
    end

    it "should require a user to be logged in to comment on a frame" do
      frame = FactoryGirl.create(:frame)

      post :create, params: {frame_id: frame.id, comment: {message:'awesome frame'}}

      expect(response).to redirect_to new_user_session_path
    end

    it "should return http status code of not found if the frame id isn't found" do
      frame = FactoryGirl.create(:frame)

      user = FactoryGirl.create(:user)

      sign_in user

      post :create, params: {frame_id: 'YOLOSWAG', comment: {message:'awesome frame'}}

      expect(response).to have_http_status(:not_found)
    end


  end

end
