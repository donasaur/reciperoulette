require 'rails_helper'


#RSpec.describe User, :type => :model do
#  pending "add some examples to (or delete) #{__FILE__}"
#end



describe "validations" do
  before(:each) do
    @user = User.new(email: "obama@whitehouse.gov", password: 'password', password_confirmation: 'password')
  end

  it "should accept a valid username-password pair" do
    expect(@user.valid?).to eq true
  end

end