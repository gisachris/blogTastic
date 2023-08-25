require 'rails_helper'

RSpec.describe Comment, type: :model do
  let(:user) { User.create(name: 'Alice') }
  let(:post) { Post.create(title: 'Test Post', text: 'Testing', author: user) }
  subject { Comment.new(text: 'Hello', author: user, post:) }

  it 'is valid with valid attributes' do
    expect(subject).to be_valid
  end

  it 'is not valid without text' do
    subject.text = nil
    expect(subject).to_not be_valid
  end

  it 'is associated with an author' do
    expect(subject.author).to eq(user)
  end

  it 'is associated with a post' do
    expect(subject.post).to eq(post)
  end

  it 'updates the comments counter for a post after creating a comment' do
    user = User.create(name: 'Test User')
    post = Post.create(title: 'Test Post', comments_counter: 0, likes_counter: 0, author: user)
    Comment.create(author: user, post:, text: 'Test comment')
    post.reload
    expect(post.comments_counter).to eq(1)
  end
end
