require 'rails_helper'

RSpec.describe Like, type: :model do
  # Create Post and users to add Likes
  before(:each) do
    new_post = Post.create(title: 'My first post', author: User.create(name: 'John Doe'))
    other_user = User.create(name: 'Jane Smith')
    @like = Like.create(author: other_user, post: new_post)
  end

  it 'UpdatesLikesCounter increments post likes_counter' do
    expect(@like.post.likes_counter).to be 1
    Like.create(author: @like.post.author, post: @like.post)
    expect(@like.post.likes_counter).to be 2
  end
end
