require 'rails_helper'

RSpec.describe 'Users', type: :request do

  let!(:valid_attributes){
   { 
    name: 'Tom', 
    photo: 'https://unsplash.com/photos/F_-0BxGuVvo',
    bio: 'Teacher from Mexico.',
    posts_counter: 0
   }
  }

  let!(:invalid_attributes){
    { 
    name: '', 
    photo: 'https://unsplash.com/photos/F_-0BxGuVvo',
    bio: 'Teacher from Mexico.'
   }
  }

  describe 'GET /index' do
    it "loads the index page succesfully with correct attributes" do
      User.create! valid_attributes
      get users_url
      expect(response).to be_successful
    end

    it "Has the correct status" do
      User.create! valid_attributes
      get users_url
      expect(response.status).to eq(200)
    end

    it "Loads the correct template view" do
      User.create! valid_attributes
      get users_url
      expect(response).to render_template(:index)
    end

    it "Has the correct placeholder text" do
      User.create! valid_attributes
      get users_url
      expect(response.body).to include ('Welcome to the homepage')
    end
  end

  describe 'GET /show' do
    it 'loads the specific user' do
      user = User.create! valid_attributes
      get user_url(user)
      expect(response).to be_successful
    end

    it 'redirects to the created user' do
    end

    it "Has the correct status" do
      user = User.create! valid_attributes
      get user_url(user)
      expect(response.status).to eq(200)
    end

    it "Loads the correct template view" do
      user = User.create! valid_attributes
      get user_url(user)
      expect(response).to render_template(:show)
    end

    it "Has the correct placeholder text" do
      user = User.create! valid_attributes
      get user_url(user)
      expect(response.body).to include ('Here is a specific user')
    end
  end


end
