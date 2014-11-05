class UsersController < ApplicationController

  # test
  def new
  end

  def create
  end

  def show
  end

  def edit
  end

  def update
    # @user = current_user
    # @pantry = @user.pantry
    # if params[:commit] == 'Remove Ingredient'
    #   @ingredient = Ingredient.find(params[:ingredient][:ingredient_id])
    #   @pantry.ingredients.delete(@ingredient)
    #   @pantry.save
    # elsif params[:commit] == 'Add Ingredient'
    #   ingredient = Ingredient.where(name: params[:ingredient][:name]).first
    #   if ingredient && !@pantry.ingredients.exists?(ingredient)
    #     @pantry.ingredients << ingredient
    #     @pantry.save
    #   elsif !ingredient
    #     # Probably want to flash message that ingredient couldn't be found
    #     flash.now[:ingredienterror] = "Sorry, #{params[:ingredient][:name]} is not a valid ingredient"
    #   end
    # end
    # render 'dashboard'
  end

  def destroy
  end

  def dashboard
    @user = current_user
    if @user
      @pantry = @user.pantry
      @ingredients = @pantry.ingredients.sort_by {|a| a.pantry_ingredients[0].position}
    else
      render 'new'
    end
  end

  # list_of_recipe_ids is set to a list when they play roulette (can be empty)
  # any time they hit roulette page, force re-query of database
  def roulette
    unless params[:recipe_id].nil?
      render_page_with_selected_recipe(params[:recipe_id])
      return
    end

    set_of_recipes = gather_user_recipes
    @list_of_recipe_ids = weighted_randomize(set_of_recipes)

    render_appropriate_page(@list_of_recipe_ids)
  end

  def block
    @user = current_user

    recipe = Recipe.find(params[:id])
    recipe_already_blocked = @user.blockedrecipelist.recipes.where(id: recipe.id).length > 0
    @user.blockedrecipelist.recipes << recipe unless recipe_already_blocked

    roulette
  end

  private

    def weighted_randomize(set_of_recipes)

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
        list_of_recipe_frequencies << (recipe.ingredients & @user.pantry.ingredients).length
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
      @recipe = Recipe.find(recipe_id)
      render partial: 'roulettemain'
    end

    def render_appropriate_page(list_of_recipe_ids)
      if list_of_recipe_ids.length > 0
        @recipe = Recipe.find(list_of_recipe_ids[0])
        render 'roulette'
      else
        render "sorry"
      end
    end

    def gather_user_recipes
      user_ingredients = current_user.pantry.ingredients # list of ingredient objects
      recipe_search_results = Set.new

      user_ingredients.each do |ingredient|
        matching_recipes = ingredient.recipes # each ingredient should be involved in one or more recipes
        recipe_search_results.merge(matching_recipes)
      end

      current_user.blockedrecipelist.recipes.each do |blocked_recipe|
        recipe_search_results.delete?(blocked_recipe)
      end

      recipe_search_results
    end

end
