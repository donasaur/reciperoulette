require 'rails_helper'
include Devise::TestHelpers

RSpec.describe PantriesController, :type => :controller do

  before(:each) do
    @user = User.new(email: "obama@whitehouse.gov", password: 'password', password_confirmation: 'password')
    @user.save
    sign_in @user
    @pantry = @user.pantry
    @ingredient = Ingredient.create(id: 1, name: "salt")
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

  it "should not add an invalid ingredient to the user pantry" do
    params = {}
    params[:commit] = "Add Ingredient"
    params[:ingredient_name] = "poop"
    post :update, parameters = params
    expect(response).to redirect_to users_dashboard_path
    expect(@user.pantry.ingredients.find_by(name: "poop")).to be nil
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

  it "should sort pantry ingredients properly given correct params" do
    @pantry.ingredients << @ingredient
    @pantry.ingredients << Ingredient.create(id: 2, name: "pepper")
    @pantry.ingredients << Ingredient.create(id: 3, name: "msg")
    @pantry.ingredients << Ingredient.create(id: 4, name: "oregano")
    params = {}
    params[:ingredient] = ["3", "4", "2", "1"]
    post :sort, parameters = params
    expect(@pantry.ingredients.sort_by {|a| a.pantry_ingredients[0].position}.first.id).to be 3
  end
end
