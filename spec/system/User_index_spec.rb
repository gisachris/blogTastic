require 'rails_helper'

RSpec.describe "user index page tests", type: :system do

  before(:each) do
    @user1 = User.create(name: 'chris', photo: 'https://images3.alphacoders.com/690/690494.jpg', bio: 'student', posts_counter: 3)
    @user2 = User.create(name: 'ben', photo: 'https://images3.alphacoders.com/690/690494.jpg', bio: 'Explorer', posts_counter: 7)
    @user3 = User.create(name: 'laila', photo: 'https://images3.alphacoders.com/690/690494.jpg', bio: 'consultant', posts_counter: 15)
  end

  describe "User contents" do
    before(:each) do
      visit users_path
    end

    it "should see the username of all other users." do
      User.all.each do |user|
        expect(page).to have_content(@user1.name)
        expect(page).to have_content(@user2.name)
        expect(page).to have_content(@user3.name)
      end
    end

    it "Should see the profile picture for each user." do
      expect(page).to have_selector("img[src='https://images3.alphacoders.com/690/690494.jpg']")
    end
    
    it "Should see the number of posts each user has written." do
      expect(page).to have_content("Number Of Posts: 3")
      expect(page).to have_content("Number Of Posts: 7")
      expect(page).to have_content("Number Of Posts: 15")
    end
  end

  describe "User interactions" do
    before(:each) do
      visit users_path
    end
  
    it "When I click on a user, I am redirected to that user's show page." do
      first("a[href='#{user_path(@user1)}']").click
  
      expect(page).to have_current_path(user_path(@user1))
    end
  end
end