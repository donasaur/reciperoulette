require 'rails_helper'
include Devise::TestHelpers

RSpec.describe UsersController, :type => :controller do

  describe "logging in activity" do

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

  describe "user activity" do

    before(:each) do
      load Rails.root + "db/seeds.rb"
      @user = User.where(email: "test@example.com").first
      sign_in @user
      @spaghetti = Recipe.find_by(name: "Spaghetti")
      @chicken_fajitas = Recipe.find_by(name: "Chicken Fajitas")
      @roast_chicken = Recipe.find_by(name: "Roast Chicken")
      @scrambled_eggs = Recipe.find_by(name: "Scrambled Eggs")
      @quesadilla = Recipe.find_by(name: "Quesadilla")
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

      expect(assigns(:list_of_recipe_ids)).to include(@spaghetti.id)
      expect(assigns(:list_of_recipe_ids)).to include(@chicken_fajitas.id)
      expect(assigns(:list_of_recipe_ids)).to include(@roast_chicken.id)
      expect(assigns(:list_of_recipe_ids)).to include(@scrambled_eggs.id)
    end

    it "should make sure that unmatched recipes are not displayed to the user" do
      post :roulette, { commit: 'Play Roulette',
                        pantry: { ingredient_ids: @user.pantry.ingredients.pluck(:id) },
                        tags: { tag_ids: Tag.pluck(:id) } }    
      expect(response).to render_template('users/roulette')
      expect(assigns(:list_of_recipe_ids)).not_to include(@quesadilla.id)
    end

    it "should make sure that sending a POST request to /users/block/recipe_name prevents recipe from being shown again" do
      post :block, { :id => @spaghetti.id,
                      commit: 'Play Roulette',
                      pantry: { ingredient_ids: @user.pantry.ingredients.pluck(:id) },
                      tags: { tag_ids: Tag.pluck(:id) } }

      post :roulette
      expect(assigns(:list_of_recipe_ids)).not_to include(@spaghetti.id)
      expect(assigns(:list_of_recipe_ids)).to include(@chicken_fajitas.id)
      expect(assigns(:list_of_recipe_ids)).to include(@roast_chicken.id)
      expect(assigns(:list_of_recipe_ids)).to include(@scrambled_eggs.id)
    end

    it "should make sure sorry page is displayed when there are no matched recipes" do
      post :block, { :id => @spaghetti.id }
      post :block, { :id => @chicken_fajitas.id }
      post :block, { :id => @roast_chicken.id }
      post :block, { :id => @scrambled_eggs.id }

      post :roulette
      expect(response).to render_template('users/sorry')
    end

    it "should properly save a recipe" do
      post :save, { id: @spaghetti.id }
      expect(response).to redirect_to(recipe_path(Recipe.find(@spaghetti.id)))
      expect(flash[:notice]).to eq "Recipe saved!"
      expect(@user.recipes.length).to eq 1
      post :save, { id: @spaghetti.id }
      expect(response).to redirect_to(recipe_path(Recipe.find(@spaghetti.id)))
      expect(flash[:notice]).to eq "Recipe already saved!" 
      expect(@user.recipes.length).to eq 1
    end

    it "should make sure increasing threshold will stop showing certain recipes", :type => 'threshold' do
      @user.threshold = 10
      @user.save
      post :roulette

      expect(assigns(:list_of_recipe_ids)).not_to include(@spaghetti.id)
      expect(assigns(:list_of_recipe_ids)).not_to include(@chicken_fajitas.id)
      expect(assigns(:list_of_recipe_ids)).not_to include(@roast_chicken.id)
      expect(assigns(:list_of_recipe_ids)).not_to include(@scrambled_eggs.id)      
    end

    it "makes sure that unblocking recipes work", :type => 'unblock' do
      post :block, { :id => @spaghetti.id }
      post :block, { :id => @chicken_fajitas.id }
      post :block, { :id => @roast_chicken.id }
      post :block, { :id => @scrambled_eggs.id }

      post :unblock, { :recipe=> {"Spaghetti" => 1, "Roast Chicken" => 1}}

      post :roulette

      expect(assigns(:list_of_recipe_ids)).to include(@spaghetti.id)
      expect(assigns(:list_of_recipe_ids)).not_to include(@chicken_fajitas.id)
      expect(assigns(:list_of_recipe_ids)).to include(@roast_chicken.id)
      expect(assigns(:list_of_recipe_ids)).not_to include(@scrambled_eggs.id)
    end
  end

end

