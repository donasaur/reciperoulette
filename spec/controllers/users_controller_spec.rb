require 'rails_helper'

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
  end

  describe "user activity" do

    before(:each) do
      load Rails.root + "db/seeds_snapshot_iter3.rb"
      @user = User.where(email: "test@example.com").first
      sign_in @user
      @spaghetti = Recipe.find_by(name: "Spaghetti")
      @chicken_fajitas = Recipe.find_by(name: "Chicken Fajitas")
      @roast_chicken = Recipe.find_by(name: "Roast Chicken")
      @scrambled_eggs = Recipe.find_by(name: "Scrambled Eggs")
      @quesadilla = Recipe.find_by(name: "Quesadilla")
      @chicken_pot_pie = Recipe.find_by(name: "Chicken Pot Pie")
      @chicken_soup = Recipe.find_by(name: "Chicken and Dumpling Soup")
    end

    # Note: only one recipe is shown to the user at a time
    # but the list of possible recipes is fetched in advance
    # so that the user does not requery the database every time
    # the user wants to view the next recipe in the roulette
    it "should make sure that matched recipes are displayed to the user" do
      post :roulette, { commit: 'Play Roulette',
                        pantry: { ingredient_ids: @user.pantry.ingredients.pluck(:id) },
                        tags: { tag_ids: Tag.pluck(:id) },
                        max_prep_time: '',
                        max_cook_time: '' }
      expect(response).to render_template('users/roulette')
      expect(assigns(:list_of_recipe_ids)).to include(@spaghetti.id)
      expect(assigns(:list_of_recipe_ids)).to include(@chicken_fajitas.id)
      expect(assigns(:list_of_recipe_ids)).to include(@roast_chicken.id)
    end

    it "should make sure that unmatched recipes are not displayed to the user" do
      post :roulette, { commit: 'Play Roulette',
                        pantry: { ingredient_ids: @user.pantry.ingredients.pluck(:id) },
                        tags: { tag_ids: Tag.pluck(:id) },
                        max_prep_time: '',
                        max_cook_time: '' }
      expect(response).to render_template('users/roulette')
      expect(assigns(:list_of_recipe_ids)).not_to include(@quesadilla.id)
    end

    it "should not match recipes which have recipes exceeding the max prep time" do
      post :roulette, { commit: 'Play Roulette',
                        pantry: { ingredient_ids: @user.pantry.ingredients.pluck(:id) },
                        tags: { tag_ids: Tag.pluck(:id) },
                        max_prep_time: '5',
                        max_cook_time: '' }
      expect(response).to render_template('users/roulette')
      expect(assigns(:list_of_recipe_ids)).to include(@spaghetti.id)
      expect(assigns(:list_of_recipe_ids)).not_to include(@chicken_fajitas.id)
      expect(assigns(:list_of_recipe_ids)).not_to include(@roast_chicken.id)
      expect(assigns(:list_of_recipe_ids)).to include(@scrambled_eggs.id)
    end

    it "should not match recipes which have recipes exceeding the max cook time" do
      post :roulette, { commit: 'Play Roulette',
                        pantry: { ingredient_ids: @user.pantry.ingredients.pluck(:id) },
                        tags: { tag_ids: Tag.pluck(:id) },
                        max_prep_time: '',
                        max_cook_time: '10' }
      expect(response).to render_template('users/roulette')
      expect(assigns(:list_of_recipe_ids)).not_to include(@spaghetti.id)
      expect(assigns(:list_of_recipe_ids)).to include(@chicken_fajitas.id)
      expect(assigns(:list_of_recipe_ids)).not_to include(@roast_chicken.id)
      expect(assigns(:list_of_recipe_ids)).to include(@scrambled_eggs.id)
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
      Recipe.all.each do |recipe|
        post :block, { id: recipe.id }
      end
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

    it "should properly delete a saved recipe" do
      @user.recipes << @spaghetti
      post :delete, {recipe_id: @spaghetti.id}
      @user.reload
      expect(@user.recipes.length).to eq 0
    end

    it "should not fail when deleting a saved recipe the user does not have" do
      @user.recipes << @spaghetti
      post :delete, {recipe_id: @roast_chicken.id}
      @user.reload
      expect(@user.recipes.length).to eq 1
    end

    it "should be able to delete many saved recipes" do
      @user.recipes << @spaghetti
      @user.recipes << @roast_chicken
      @user.recipes << @scrambled_eggs
      @user.recipes << @quesadilla
      post :delete, {recipe_id: @roast_chicken.id}
      post :delete, {recipe_id: @quesadilla.id}
      post :delete, {recipe_id: @spaghetti.id}
      @user.reload
      expect(@user.recipes.length).to eq 1
    end

    it "should make sure increasing threshold will stop showing certain recipes", :type => 'threshold' do
      @user.threshold = 100
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

