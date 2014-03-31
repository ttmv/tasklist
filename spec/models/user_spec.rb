require 'spec_helper'

describe User do
  it "new user is created with a valid username and a password" do
    user = User.create username: "user1", password: "Password1", password_confirmation: "Password1"

    expect(user).to be_valid
    expect(User.count).to eq(1)
  end

  it "is not created without username" do
    user = User.create password: "Password1", password_confirmation: "Password1"

    expect(user).not_to be_valid
    expect(User.count).to eq(0)
  end
end
