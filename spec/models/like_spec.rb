require 'rails_helper'

RSpec.describe Like, type: :model do
  let(:user) { User.create(name: 'Alice') }
  let(:post) { Post.create(title: 'Test Post', text: 'Testing', author: user) }
  subject { Like.new(author: user, post: post) }

  it "is valid with valid attributes" do
    expect(subject).to be_valid
  end

  it "is associated with an author" do
    expect(subject.author).to eq(user)
  end

  it "is associated with a post" do
    expect(subject.post).to eq(post)
  end

  it 'updates the likes counter for a post after creating a like' do
    user = User.create(name: 'Test User')
    post = Post.create(title: 'Test Post', comments_counter: 0, likes_counter: 0, author: user)
    Like.create(author: user, post:)
    post.reload
    expect(post.likes_counter).to eq(1)
  end
end
