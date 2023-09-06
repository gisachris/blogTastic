require 'rails_helper'

RSpec.describe 'user Post show View Testing', type: :system do
  before(:each) do
    @user = User.create(name: 'chris', photo: 'https://images3.alphacoders.com/690/690494.jpg', bio: 'student',
                        posts_counter: 0)
    @post1 = Post.create(author: @user, title: 'first post', text: 'This is my first post', comments_counter: 0,
                         likes_counter: 0)
    @comment1 = Comment.create(post: @post1, author: @user, text: 'first comment!')
    @comment2 = Comment.create(post: @post1, author: @user, text: 'second comment!')
    @comment3 = Comment.create(post: @post1, author: @user, text: 'Third comment!')
  end
  describe 'Page View Contents Testing' do
    before(:each) do
      visit user_post_path(@user, @post1)
    end
    it "Should see the post's title." do
      expect(page).to have_content("Post # #{@post1.id}")
    end
    it 'Should see who wrote the post.' do
      expect(page).to have_content("Post # #{@post1.id} by #{@post1.author.name}")
    end
    it 'Should see how many comments it has.' do
      expect(page).to have_content("Comments: #{@post1.comments_counter}")
    end
    it 'Should see how many likes it has.' do
      expect(page).to have_content("Likes: #{@post1.likes_counter}")
    end
    it 'Should see the post body.' do
      expect(page).to have_content(@post1.text.to_s)
    end
    it 'Should see the username of each commentor.' do
      @post1.comments.all.each do |comment|
        expect(page).to have_content(comment.author.name.to_s)
      end
    end
    it 'Should see the comment each commentor left.' do
      @post1.comments.all.each do |comment|
        expect(page).to have_content(comment.text.to_s)
      end
    end
  end
end
