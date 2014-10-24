require 'rails_helper'
include Devise::TestHelpers

RSpec.describe UsersController, :type => :controller do
  before(:each) do
    @user = User.new(email: "obama@whitehouse.gov", password: 'password', password_confirmation: 'password')
    @user.save
    sign_in @user
    @ingredient = Ingredient.create(name: "salt")
  end

  it "should add an ingredient to the user pantry" do
    expect(@user.valid?).to be true
    params = {}
    params[:commit] = "Add Ingredient"
    params[:ingredient] = {}
    params[:ingredient][:name] = @ingredient.name
    post :update, parameters = params
    expect(response).to render_template('users/dashboard')
    expect(@user.pantry.ingredients.exists?(@ingredient)).to be true
    expect(flash.now[:ingredienterror]).to be_nil
  end

  it "should remove an ingredient to the user pantry" do
    expect(@user.valid?).to be true
    @user.pantry.ingredients << @ingredient
    expect(@user.pantry.ingredients.exists?(@ingredient)).to be true
    params = {}
    params[:commit] = "Remove Ingredient"
    params[:ingredient] = {}
    params[:ingredient][:ingredient_id] = @ingredient.id
    post :update, parameters = params
    expect(response).to render_template('users/dashboard')
    expect(@user.pantry.ingredients.exists?(@ingredient)).to be false
    expect(flash.now[:ingredienterror]).to be_nil
  end

  it "should not add an ingredient to the user pantry if ingredient not in database" do
    expect(@user.valid?).to be true
    bad_ingredient = 'pepper'
    params = {}
    params[:commit] = "Add Ingredient"
    params[:ingredient] = {}
    params[:ingredient][:name] = bad_ingredient
    post :update, parameters = params
    expect(response).to render_template('users/dashboard')
    expect(@user.pantry.ingredients.exists?( :name => bad_ingredient )).to be false
    expect(flash.now[:ingredienterror]).to_not be_nil
  end

  it "should render new if not logged in" do
    sign_out @user
    get :dashboard
    expect(response).to render_template('users/new')
  end

  it "should render dashboard if logged in" do
    get :dashboard
    expect(response).to render_template('users/dashboard')
  end
end
