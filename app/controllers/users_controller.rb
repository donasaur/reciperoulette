class UsersController < ApplicationController

  def dashboard
    @user = current_user
    if @user
      @pantry = @user.pantry
      render 'dashboard'
    else
      render 'new'
    end
  end

  # list_of_recipe_ids is set to a list when they play roulette (can be empty)
  # any time they hit roulette page, force re-query of database
  def roulette
    @user = current_user
    @pantry = @user.pantry
    @tags = []
    if params["commit"] == "Play Roulette"
      ingredient_ids = []
      if params["pantry"]
        ingredient_ids = params["pantry"]["ingredient_ids"].map(&:to_i)
      end
      @pantry.ingredients.each do |ingredient|
        pantry_ingredient = @pantry.pantry_ingredients.find_by(ingredient_id: ingredient.id)
        active = ingredient_ids.include?(ingredient.id)
        pantry_ingredient.active = active
        pantry_ingredient.save
      end
      if params["tags"]
        @tags = Tag.where(id: params["tags"]["tag_ids"].map(&:to_i))
      end
    end

    @active_ingredients = get_active_ingredients(@user)

    unless params[:recipe_id].nil?
      render_page_with_selected_recipe(params[:recipe_id])
      return
    end

    set_of_recipes = gather_user_recipes(@active_ingredients, @tags)
    @list_of_recipe_ids = weighted_randomize(set_of_recipes, @active_ingredients)

    render_appropriate_page(@list_of_recipe_ids)
  end

  def block
    @user = current_user

    recipe = Recipe.find(params[:id])
    recipe_already_blocked = @user.blockedrecipelist.recipes.where(id: recipe.id).length > 0
    @user.blockedrecipelist.recipes << recipe unless recipe_already_blocked

    dashboard
  end

  def unblock
    recipes_to_be_unblocked = []
    user_blocked_recipes = current_user.blockedrecipelist.recipes
    params[:recipe].keys.each do |recipe_name|
      recipes_to_be_unblocked << user_blocked_recipes.where(name: recipe_name)
    end
    user_blocked_recipes.destroy(recipes_to_be_unblocked)

    redirect_to("/users/edit")
  end

  def set_threshold
    current_user.threshold = params[:threshold]
    current_user.save
    redirect_to("/users/edit")
  end

  def save
    @user = current_user
    recipe = Recipe.find(params[:id])
    unless @user.recipes.include?(recipe)
      @user.recipes << recipe
      flash[:notice] = "Recipe saved!"
    else
      flash[:notice] = "Recipe already saved!"
    end
    redirect_to recipe_path(recipe)
  end

  def delete #delete saved recipe from user's saved recipes
    recipe_id = params[:recipe_id].to_i
    user = current_user
    deleted_recipe = Recipe.find(recipe_id)
    user.recipes.destroy(deleted_recipe)
    user.save
    redirect_to users_dashboard_path
  end

  def unblock_all
    current_user.blockedrecipelist.recipes.clear

    render :nothing => true
  end

  private

    # For a given user, returns a list of ingredient objects that are active in the pantry
    # If no ingredients are active, will return all ingredients in pantry
    def get_active_ingredients(user)
      pantry = user.pantry
      pantry_ingredients = PantryIngredient.where(pantry_id: pantry.id, active: true)
      if pantry_ingredients.empty?
        pantry_ingredients = PantryIngredient.where(pantry_id: pantry.id)
      end

      active_ingredients = []
      pantry_ingredients.each do |pantry_ingredient|
        active_ingredients << Ingredient.find(pantry_ingredient.ingredient_id)
      end
      return active_ingredients
    end

    def weighted_randomize(set_of_recipes, active_ingredients)

      # Initialization
      @user = current_user # to get list of user ingredients
      list_of_recipes = set_of_recipes.to_a
      list_of_recipe_frequencies = []

      rtn_list_of_recipe_ids = []
      num_of_recipes = list_of_recipes.length

      # generate list of random numbers
      list_of_samples = (0..num_of_recipes).map do |recipe_num|
        rand
      end

      # algorithm portion
      # recipe with twice the number of ingred. matched is twice as likely to show up
      list_of_recipes.each do |recipe|
        list_of_recipe_frequencies << (recipe.ingredients & active_ingredients).length
      end

      # each itertion adds one recipe id to the rtn_list_of_recipe_ids
      (0..num_of_recipes).each do
        normalization_factor = list_of_recipe_frequencies.inject(:+)

        list_of_recipe_probabilities = list_of_recipe_frequencies.map do |frequency|
          frequency.fdiv(normalization_factor)
        end

        cumulative_probability_array = cumulative_sum_array(list_of_recipe_probabilities)

        cumulative_probability_array.each_with_index do |cumulative_probabiity, index|
          if list_of_samples[index] < cumulative_probabiity
            # remove relevant recipe from list_of_recipes, list_of_recipe_frequencies
            rtn_list_of_recipe_ids << list_of_recipes.delete_at(index).id
            list_of_recipe_frequencies.delete_at(index)
            break
          end
        end
      end

      rtn_list_of_recipe_ids

    end

    def cumulative_sum_array(array)
      sum = 0
      array.map{|x| sum += x}
    end

    def render_page_with_selected_recipe(recipe_id)
      if recipe_id == "None"
        render partial: 'sorrymessage'
      else
        @recipe = Recipe.find(recipe_id)
        render partial: 'roulettemain'
      end
    end

    def render_appropriate_page(list_of_recipe_ids)
      if list_of_recipe_ids.length > 0
        @recipe = Recipe.find(list_of_recipe_ids[0])
        render 'roulette'
      else
        render 'sorry'
      end
    end

    def gather_user_recipes(user_ingredients, tags)
      recipe_search_results = Set.new

      user_ingredients.each do |ingredient|
        matching_recipes = ingredient.recipes # each ingredient should be involved in one or more recipes
        recipe_search_results.merge(matching_recipes)
      end

      current_user.blockedrecipelist.recipes.each do |blocked_recipe|
        recipe_search_results.delete?(blocked_recipe)
      end

      if tags.length != 0
        recipe_search_results.each do |recipe|
          if (recipe.tags & tags).length == 0
            recipe_search_results.delete?(recipe)
          end
        end
      end

      # this snippet of code is responsible for enforcing threshold
      recipe_search_results.select! do |recipe|
        (recipe.ingredients & user_ingredients).length >= current_user.threshold
      end

      recipe_search_results
    end

end
