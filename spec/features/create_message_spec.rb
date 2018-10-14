require 'rails_helper'

describe "create message", :js do
  let!(:user) { 
    User.create(
    email: Faker::Internet.free_email,
    password: "asdfasdf") 
  }
  let!(:profile) {
    Profile.create(
      user: user,
      name: "test"
    )
  }
  let!(:recipient) { 
    User.create(
    email: Faker::Internet.free_email,
    password: "asdfasdf") 
  }
  let!(:recipient_profile) {
    Profile.create(
      user: recipient,
      name: "test"
    )
  }

  it "creates a notification" do
    user.profile = profile
    user.save
    visit new_user_session_path 
    fill_in "Email", with: user.email
    fill_in "Password", with: user.password
    click_on "Log in"
    visit profile_messages_path(recipient_profile.id)
    fill_in "message", with: "test"
    expect { find("#message").native.send_keys(:return) }.to change{Notification.count}.by(1)
  end
end