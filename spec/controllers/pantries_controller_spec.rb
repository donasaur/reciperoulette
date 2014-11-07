require 'rails_helper'
include Devise::TestHelpers

RSpec.describe PantriesController, :type => :controller do

  before(:each) do
    @user = User.new(email: "obama@whitehouse.gov", password: 'password', password_confirmation: 'password')
    @user.save
    sign_in @user
    @pantry = @user.pantry
    @ingredient = Ingredient.create(name: "salt")
  end

  it "should validate the tested user & pantry" do
    expect(@user.valid?).to be true
    expect(@pantry.valid?).to be true
  end

  it "should add an ingredient to the user pantry" do
    params = {}
    params[:commit] = "Add Ingredient"
    params[:ingredient_name] = @ingredient.name
    post :update, parameters = params
    expect(response).to redirect_to users_dashboard_path
    expect(@user.pantry.ingredients.exists?(@ingredient)).to be true
  end

  it "should remove an ingredient to the user pantry" do
    @user.pantry.ingredients << @ingredient
    expect(@user.pantry.ingredients.exists?(@ingredient)).to be true
    params = {}
    params[:commit] = "Delete Ingredient"
    params[:ingredient] = @ingredient.id
    post :update, parameters = params
    expect(response).to redirect_to users_dashboard_path
    expect(@user.pantry.ingredients.exists?(@ingredient)).to be false
  end

  it "should not add an ingredient to the user pantry if ingredient already in pantry" do
    expect(@user.pantry.ingredients.where( :name => @ingredient.name ).count).to eq 0
    params = {}
    params[:commit] = "Add Ingredient"
    params[:ingredient_name] = @ingredient.name
    post :update, parameters = params
    expect(response).to redirect_to users_dashboard_path
    expect(@user.pantry.ingredients.where( :name => @ingredient.name ).count).to eq 1
    post :update, parameters = params
    expect(response).to redirect_to users_dashboard_path
    expect(@user.pantry.ingredients.where( :name => @ingredient.name ).count).to eq 1
  end
end
