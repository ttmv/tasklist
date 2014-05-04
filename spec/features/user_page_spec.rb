require 'spec_helper'

describe 'An existing user' do
  before :each do
    FactoryGirl.create(:user)
    FactoryGirl.create(:user, username: "user2")
    visit signin_path
  end

  it "can sign in with good username and password" do
    fill_in('username', with:'testuser')
    fill_in('password', with:'testpass')
    click_button "Log in"

    expect(page).to have_content "Signed in: testuser Signout"
  end

  it "can not sign in without proper username" do
    fill_in('username', with:'test')
    fill_in('password', with:'testpass')
    click_button "Log in"

    expect(page).to have_content "username and password do not match"
  end

  it "can not sign in without proper password" do
    fill_in('username', with:'testuser')
    fill_in('password', with:'test')
    click_button "Log in"

    expect(page).to have_content "username and password do not match"
  end

  it "is listed on users page" do
    visit users_path
    expect(page).to have_content "testuser"
    expect(page).to have_content "user2"
  end
end

describe 'when signed in' do
  before :each do
    user = FactoryGirl.create(:user)
    sign_user_in
  end

  it "can sign out by clicking signout link" do
    click_link 'Signout'

    expect(page).to have_content 'Signin New user'

    visit tasks_path
    expect(page).to have_content 'Sign in'
    expect(page).to have_content 'Or create account'
  end

  it 'can change password' do
    click_link 'testuser'
    click_link 'Change password'
    fill_in('new password', with:'test_new')
    fill_in('new password confirmation', with:'test_new')

    expect{click_button 'Update User'}.not_to change{User.count}
    expect(page).to have_content 'Password was successfully changed.'

    click_link 'Signout'
    visit signin_path
    fill_in('username', with:'testuser')
    fill_in('password', with:'test_new')
    click_button 'Log in'    

    expect(page).to have_content "Signed in: testuser Signout"
  end
end

describe 'A new user' do
  it 'can create an account' do
    visit signup_path

    fill_in('Username', with:'testuser')
    fill_in('Password', with:'test')
    fill_in('Password confirmation', with:'test')
    expect{click_button 'Create User'}.to change{User.count}.by(1)
  end

  it 'can not create an account with an existing username' do
    FactoryGirl.create(:user)
    visit signup_path

    fill_in('Username', with:'testuser')
    fill_in('Password', with:'test')
    fill_in('Password confirmation', with:'test')

    expect{click_button 'Create User'}.not_to change{User.count}
    expect(page).to have_content 'Username has already been taken'
  end
end
