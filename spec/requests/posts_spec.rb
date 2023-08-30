require 'rails_helper'

RSpec.describe 'Posts', type: :request do
  let!(:author) {
    User.create!(
      name: 'Tom', 
      photo: 'https://unsplash.com/photos/F_-0BxGuVvo',
      bio: 'Teacher from Mexico.',
      posts_counter: 0
    )
  }

  let!(:valid_attributes){
   { 
    title: 'Tom \'s post', 
    text: 'This is a post!',
    comments_counter: 0,
    likes_counter: 0,
    author: author
   }
  }

  let!(:invalid_attributes){
    { 
      title: '', 
      text: 'This is a post!'
   }
  } 

  describe 'GET /index' do
    it "loads the index page succesfully with correct attributes" do
      Post.create! valid_attributes
      get user_posts_url(author)
      expect(response).to be_successful
    end

    it "Has the correct status" do
      Post.create! valid_attributes
      get user_posts_url(author)
      expect(response.status).to eq(200)
    end

    it "Loads the correct template view" do
      Post.create! valid_attributes
      get user_posts_url(author)
      expect(response).to render_template(:index)
    end

    it "Has the correct placeholder text" do
      Post.create! valid_attributes
      get user_posts_url(author)
      expect(response.body).to include ('Here is a list of all posts for a given user')
    end
  end

  describe 'GET /show' do
    it 'loads the specific Post' do
      post = Post.create! valid_attributes
      get user_post_url(author,post)
      expect(response).to be_successful
    end

    it "Has the correct status" do
      post = Post.create! valid_attributes
      get user_post_url(author,post)
      expect(response.status).to eq(200)
    end

    it "Loads the correct template view" do
      post = Post.create! valid_attributes
      get user_post_url(author,post)
      expect(response).to render_template(:show)
    end

    it "Has the correct placeholder text" do
      post = Post.create! valid_attributes
      get user_post_url(author,post)
      expect(response.body).to include ('Here is a specific post for a given user')
    end
  end
end
