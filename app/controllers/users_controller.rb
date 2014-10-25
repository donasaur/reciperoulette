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
    @user = current_user
    @pantry = @user.pantry
    if params[:commit] == 'Remove Ingredient'
      @ingredient = Ingredient.find(params[:ingredient][:ingredient_id])
      @pantry.ingredients.delete(@ingredient)
      @pantry.save
    elsif params[:commit] == 'Add Ingredient'
      ingredient = Ingredient.where(name: params[:ingredient][:name]).first
      if ingredient && !@pantry.ingredients.exists?(ingredient)
        @pantry.ingredients << ingredient
        @pantry.save
      elsif !ingredient
        # Probably want to flash message that ingredient couldn't be found
        flash.now[:ingredienterror] = "Sorry, #{params[:ingredient][:name]} is not a valid ingredient"
      end
    end
    render 'dashboard'
  end

  def destroy
  end

  def dashboard
    @user = current_user
    if @user
      @pantry = @user.pantry
    else
      render 'new'
    end
  end

  # list_of_recipe_names is set to a list when they play roulette (can be empty)
  # any time they hit roulette page, force re-query of database
  def roulette
    @list_of_recipe_names = gather_user_recipe_names
    @list_of_recipe_names.shuffle! # randomize names!

    render_appropriate_page(@list_of_recipe_names)
  end

  def block
    @user = current_user

    recipe = Recipe.where({name: params[:name]}).first
    recipe_already_blocked = @user.blockedrecipelist.recipes.where(id: recipe.id).length > 0
    @user.blockedrecipelist.recipes << recipe unless recipe_already_blocked

    roulette
  end

  private

    def render_appropriate_page(list_of_recipe_names)
      if list_of_recipe_names.length > 0
        @recipe_name = list_of_recipe_names[0]
        render 'roulette'
      else
        render "sorry"
      end
    end

    def gather_user_recipe_names
      user_ingredients = current_user.pantry.ingredients # list of ingredient objects
      recipe_search_results = Set.new

      user_ingredients.each do |ingredient|
        matching_recipes = ingredient.recipes # each ingredient should be involved in one or more recipes
        recipe_search_results.merge(matching_recipes)
      end

      current_user.blockedrecipelist.recipes.each do |blocked_recipe|
        recipe_search_results.delete?(blocked_recipe)
      end

      # here, recipe_search_results is a list of relevant recipes
      list_of_recipe_names = recipe_search_results.map do |recipe|
        recipe.to_s
      end

      list_of_recipe_names # return list of recipe names
    end

end
