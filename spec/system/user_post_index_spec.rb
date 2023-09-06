RSpec.describe 'User Post Index View Testing', type: :system do
  before(:all) do
    @user = User.create(name: 'chris', photo: 'https://images3.alphacoders.com/690/690494.jpg', bio: 'student',
                        posts_counter: 0)

    @post1 = Post.create(author: @user, title: 'first post', text: 'This is my first post', comments_counter: 0,
                         likes_counter: 0)
    @post2 = Post.create(author: @user, title: 'second post', text: 'This is my second post', comments_counter: 0,
                         likes_counter: 0)
    @post3 = Post.create(author: @user, title: 'third post', text: 'This is my third post', comments_counter: 0,
                         likes_counter: 0)

    @comment = Comment.create(post: @post1, author: @user, text: 'first comment!')
    @comment = Comment.create(post: @post1, author: @user, text: 'second comment!')
    @comment = Comment.create(post: @post1, author: @user, text: 'Third comment!')
  end

  describe 'Page View Contents Testing' do
    before(:each) do
      visit user_posts_path(@user)
    end

    it "Should see the user's profile picture." do
      expect(page).to have_selector("img[src='https://images3.alphacoders.com/690/690494.jpg']")
    end

    it "Should see the user's username." do
      expect(page).to have_content(@user.name)
    end

    it 'Should see the number of posts the user has written.' do
      expect(page).to have_content("Number Of Posts: #{@user.posts_counter}")
    end

    it "Should see a post's title." do
      Post.all.each do |_post|
        expect(page).to have_css('.user_post_link')
      end
    end

    it "Should see some of the post's body." do
      Post.all.each do |post|
        expect(page).to have_content(post.text)
      end
    end

    it 'Should see the first comments on a post.' do
      first_comment = Comment.first
      expect(page).to have_content(first_comment.text)
    end

    it 'Should see how many comments a post has.' do
      expect(page).to have_content('Comments: 3')
    end

    it 'Should see how many likes a post has.' do
      expect(page).to have_content('Likes: 0')
    end

    it 'Should see a section for pagination if there are more posts than fit on the view.' do
      find("a[href='#{users_path}']").click
      expect(page).to have_current_path(users_path)
    end
  end

  describe 'User Interactions Testing' do
    before(:each) do
      visit user_posts_path(@user)
    end

    it "When I click on a post, it redirects me to that post's show page." do
      find("a[href='#{user_post_path(@user, @post1)}']").click
      expect(page).to have_current_path(user_post_path(@user, @post1))
    end
  end
end
