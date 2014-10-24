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

RSpec.describe UsersController, :type => :controller do

  before(:each) do
    load Rails.root + "db/seeds_snapshot_iter1.rb"
    @user = User.where(email: "test@example.com").first
    sign_in @user
  end

  # Note: only one recipe is shown to the user at a time
  # but the list of possible recipes is fetched in advance
  # so that the user does not requery the database every time
  # the user wants to view the next recipe in the roulette
  it "should make sure that matched recipes are displayed to the user" do
    post :roulette
    expect(response).to render_template('users/roulette')
    expect(assigns(:list_of_recipe_names)).to include("Spaghetti")
    expect(assigns(:list_of_recipe_names)).to include("Chicken_Fajitas")
    expect(assigns(:list_of_recipe_names)).to include("Roast_Chicken")
    expect(assigns(:list_of_recipe_names)).to include("Scrambled_Eggs")
  end

  it "should make sure that unmatched recipes are not displayed to the user" do
    post :roulette
    expect(response).to render_template('users/roulette')
    expect(assigns(:list_of_recipe_names)).not_to include("Quesadilla")
  end

  it "should make sure that sending a POST request to /users/block/recipe_name prevents recipe from being shown again" do
    post :block, { :name => "Spaghetti" }
    expect(assigns(:list_of_recipe_names)).not_to include("Spaghetti")
    expect(assigns(:list_of_recipe_names)).to include("Chicken_Fajitas")
    expect(assigns(:list_of_recipe_names)).to include("Roast_Chicken")
    expect(assigns(:list_of_recipe_names)).to include("Scrambled_Eggs")
  end

  it "should make sure sorry page is displayed when there are no matched recipes" do
    post :block, { :name => "Spaghetti" }
    post :block, { :name => "Chicken_Fajitas" }
    post :block, { :name => "Roast_Chicken" }
    post :block, { :name => "Scrambled_Eggs" }

    post :roulette
    expect(response).to render_template('users/sorry')
  end

end

