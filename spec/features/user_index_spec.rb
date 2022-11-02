require 'rails_helper'

RSpec.describe User, type: :system do
  describe 'index page' do
    before(:each) do
      @first_photo = 'https://images.unsplash.com/photo-1508921912186-1d1a45ebb3c1?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=687&q=80'
      @second_photo = 'https://images.unsplash.com/photo-1534528741775-53994a69daeb?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=928&q=80'
      @first_user = User.create(name: 'Fernando', photo: @new_photo, bio: 'Teacher from Brazil.')
      @second_user = User.create(name: 'Amanda', photo: @new_photo, bio: 'Student from USA.')
      @third_user = User.create(name: 'Donald', photo: @first_photo, bio: 'Musician from England.')
      @fourth_user = User.create(name: 'Monica', photo: @first_photo, bio: 'Dancer from Belgium.')
      @first_post = Post.create(author: @first_user, title: 'Hello', text: 'This is my first post')
      @second_post = Post.create(author: @first_user, title: 'Hello', text: 'This is my second post')
      @third_post = Post.create(author: @first_user, title: 'Hello', text: 'This is my third post')
      @fourth_post = Post.create(author: @first_user, title: 'Hello', text: 'This is my fourth post')
      visit root_path
    end
    it 'displays the username of all other users' do
      expect(page).to have_content(@first_user.name)
      expect(page).to have_content(@second_user.name)
      expect(page).to have_content(@third_user.name)
      expect(page).to have_content(@fourth_user.name)
    end
    it 'displays the user\'s profile picture.' do
      expect(page).to have_css("img[src*='#{@first_photo}']")
      expect(page).to have_css("img[src*='#{@second_photo}']")
    end
    it 'displays the number of posts the user has written.' do
      expect(page).to have_content("Number of Posts: #{@first_user.posts_counter}")
      expect(page).to have_content("Number of Posts: #{@second_user.posts_counter}")
    end
    it 'when a user is clicked, it redirects to that user\'s show page.' do
      click_link("userlink-#{@third_user.id}")
      expect(page).to have_current_path(user_path(@third_user))
    end
  end
end
