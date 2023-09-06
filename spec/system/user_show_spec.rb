require 'rails_helper'

RSpec.describe 'User Show page view testing', type: :system do
  before(:each) do
    @user = User.create(name: 'chris', photo: 'https://images3.alphacoders.com/690/690494.jpg', bio: 'student',
                        posts_counter: 0)

    @post1 = Post.create(author: @user, title: 'first post', text: 'This is my first post', comments_counter: 0,
                         likes_counter: 0)
    @post2 = Post.create(author: @user, title: 'second post', text: 'This is my second post', comments_counter: 0,
                         likes_counter: 0)
    @post3 = Post.create(author: @user, title: 'third post', text: 'This is my third post', comments_counter: 0,
                         likes_counter: 0)
  end

  describe 'Page content testing' do
    before(:each) do
      visit user_path(@user)
    end

    it "Should see the user's profile picture." do
      expect(page).to have_selector("img[src='https://images3.alphacoders.com/690/690494.jpg']")
    end

    it "Should see the user's username." do
      expect(page).to have_content(@user.name)
    end

    it 'Should see the number of posts the user has written.' do
      expect(page).to have_content(@user.posts_counter)
    end

    it "Should see the user's bio." do
      expect(page).to have_content(@user.bio)
    end

    it "Should see the user's first 3 posts." do
      expect(page).to have_content(@post1.text)
      expect(page).to have_content(@post2.text)
      expect(page).to have_content(@post3.text)
    end

    it "Should see a button that lets me view all of a user's posts." do
      expect(page).to have_selector("a[href='#{user_posts_path(@user)}']")
    end
  end

  describe 'User interaction testing' do
    before(:each) do
      visit user_path(@user)
    end

    it "When I click a user's post, it redirects me to that post's show page." do
      find("a[href='#{user_post_path(@user, @post1)}']").click
      expect(page).to have_current_path(user_post_path(@user, @post1))
    end

    it "When I click to see all posts, it redirects me to the user's post's index page." do
      find("a[href='#{user_posts_path(@user)}']").click
      expect(page).to have_current_path(user_posts_path(@user))
    end
  end
end
