require 'rails_helper'

#RSpec.describe User, :type => :model do
#  pending "add some examples to (or delete) #{__FILE__}"
#end



describe "UserModel" do
  before(:each) do
    @user = User.new(email: "obama@whitehouse.gov", password: 'password', password_confirmation: 'password')
    @ingredient = Ingredient.create(name: "salt")
  end

  it "should accept a valid username-password pair" do
    expect(@user.valid?).to eq true
  end

  it "should not accept a password fewer than 8 characters" do
    @user.password = 'pass'
    @user.password_confirmation = 'pass'
    expect(@user.valid?).to eq false
  end

  it "should not accept if password confirmation differs from password" do
    @user.password = 'password'
    @user.password_confirmation = 'passwor1'
    expect(@user.valid?).to eq false
  end

  it "should have a valid email" do
    @user.email = "bob"
    expect(@user.valid?).to eq false
  end

  it "should have a valid email ." do
    @user.email = "user.bob"
    expect(@user.valid?).to eq false
  end

  it "should have a valid email @" do
    @user.email = "user@bob"
    expect(@user.valid?).to eq false
  end

  it "should not accept a user with the same a duplicate email" do
    user1 = User.create(email: "hello@world.gov", password: 'password', password_confirmation: 'password')
    user2 = User.new(email: "hello@world.gov", password: 'password', password_confirmation: 'password')
    expect(user2.save).to eq false
  end

end