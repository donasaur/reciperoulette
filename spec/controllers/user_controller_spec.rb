require 'rails_helper'
include Devise::TestHelpers

#RSpec.describe UserController, :type => :controller do
#end

describe UserController do
  before(:each) do
    @user = User.new(email: "obama@whitehouse.gov", password: 'password', password_confirmation: 'password')
    @user.save
    sign_in @user
    @ingredient = Ingredient.create(name: "salt")
  end

  it "should add an ingredient to the user pantry" do
    params = {}
    params[:commit] = "Add Ingredient"
    params[:ingredient] = {}
    params[:ingredient][:name] = @ingredient.name
    controller.update
    expect(response).to render_template('user/dashboard')
    #expect(@user.pantry.exists?(@ingredient)).to eq true
  end
end
