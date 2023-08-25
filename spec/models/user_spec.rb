require 'rails_helper'
RSpec.describe User, type: :model do
  subject { User.new(name: 'Tom', photo: 'https://unsplash.com/photos/F_-0BxGuVvo', bio: 'Teacher from Mexico.', posts_counter: 0) }

  before { subject.save }

  it 'Validates succesfully with correct entries' do
    expect(subject).to be_valid
  end

  it "does'nt validate with empty name" do
    subject.name = nil
    expect(subject).to_not be_valid
  end

  it 'Validates successfully with valid posts_counter value' do
    subject.posts_counter = 5
    expect(subject).to be_valid
  end

  it "Doesn't validate with negative posts_counter value" do
    subject.posts_counter = -1
    expect(subject).to_not be_valid
  end

  it 'Has an empty array of recent_posts if no posts exist' do
    expect(subject.recent_posts).to be_empty
  end

  it 'Returns recent posts when they exist' do
    test_user = User.create(name: 'brian', photo: 'img', bio: 'Teacher.', posts_counter: 0)
    Post.create(title: 'Post 1', text: 'testing Text for post 1', author: test_user, comments_counter: 0,
                likes_counter: 0)
    test_user.reload
    expect(test_user.recent_posts.size).to eq(1)
  end

  it "Returns zero recent posts when they don't exist" do
    test_user = User.create(name: 'brian', photo: 'img', bio: 'Teacher.', posts_counter: 0)
    test_user.reload
    expect(test_user.recent_posts.size).to eq(0)
  end
end
