require 'rails_helper'
include Devise::TestHelpers

RSpec.describe UsersController, :type => :controller do
  before(:each) do
    @user = User.new(email: "obama@whitehouse.gov", password: 'password', password_confirmation: 'password')
    @user.save
    sign_in @user
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
    load Rails.root + "db/seeds.rb"
    @user = User.where(email: "test@example.com").first
    sign_in @user
    @spaghetti_id = Recipe.find_by(name: "Spaghetti").id
    @chicken_fajitas_id = Recipe.find_by(name: "Chicken Fajitas").id
    @roast_chicken_id = Recipe.find_by(name: "Roast Chicken").id
    @scrambled_eggs_id = Recipe.find_by(name: "Scrambled Eggs").id
    @quesadilla_id = Recipe.find_by(name: "Quesadilla").id
  end

  # Note: only one recipe is shown to the user at a time
  # but the list of possible recipes is fetched in advance
  # so that the user does not requery the database every time
  # the user wants to view the next recipe in the roulette
  it "should make sure that matched recipes are displayed to the user" do
    post :roulette, { commit: 'Play Roulette',
                      pantry: { ingredient_ids: @user.pantry.ingredients.pluck(:id) },
                      tags: { tag_ids: Tag.pluck(:id) } }
    expect(response).to render_template('users/roulette')

    expect(assigns(:list_of_recipe_ids)).to include(@spaghetti_id)
    expect(assigns(:list_of_recipe_ids)).to include(@chicken_fajitas_id)
    expect(assigns(:list_of_recipe_ids)).to include(@roast_chicken_id)
    expect(assigns(:list_of_recipe_ids)).to include(@scrambled_eggs_id)
  end

  it "should make sure that unmatched recipes are not displayed to the user" do
    post :roulette, { commit: 'Play Roulette',
                      pantry: { ingredient_ids: @user.pantry.ingredients.pluck(:id) },
                      tags: { tag_ids: Tag.pluck(:id) } }    
    expect(response).to render_template('users/roulette')
    expect(assigns(:list_of_recipe_ids)).not_to include(@quesadilla_id)
  end

  it "should make sure that sending a POST request to /users/block/recipe_name prevents recipe from being shown again" do
    post :block, { :id => @spaghetti_id,
                    commit: 'Play Roulette',
                    pantry: { ingredient_ids: @user.pantry.ingredients.pluck(:id) },
                    tags: { tag_ids: Tag.pluck(:id) } }
    expect(assigns(:list_of_recipe_ids)).not_to include(@spaghetti_id)
    expect(assigns(:list_of_recipe_ids)).to include(@chicken_fajitas_id)
    expect(assigns(:list_of_recipe_ids)).to include(@roast_chicken_id)
    expect(assigns(:list_of_recipe_ids)).to include(@scrambled_eggs_id)
  end

  it "should make sure sorry page is displayed when there are no matched recipes" do
    post :block, { :id => @spaghetti_id }
    post :block, { :id => @chicken_fajitas_id }
    post :block, { :id => @roast_chicken_id }
    post :block, { :id => @scrambled_eggs_id }

    post :roulette
    expect(response).to render_template('users/sorry')
  end

end

