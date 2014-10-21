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
  end

  def destroy
  end

  # hasModifiedPantry (cookie key) -> True/False
  # hasModifiedPantry is set to T if they modified pantry
  # hasModifiedPantry is set to F when they play roulette
  # listOfRecipes (cookie key) -> [bread, potato]
  # listOfRecipes is set to a list when they play roulette


  # has_modified_pantry (cookie key) -> True/False
  # has_modified_pantry is set to T if they modified pantry
  # has_modified_pantry is set to F when they play roulette
  # list_of_recipe_names (cookie key) -> e.g. [bread, potato]
  # list_of_recipe_names is set to a list when they play roulette (can be empty)
  def roulette
    if has_modified_pantry == false
      update_has_modified_pantry
      render_appropriate_page(list_of_recipe_names)
    else # has_modified_pantry == true
      user_ingredients = User.ingredients # list of ingredient objects
      recipe_search_results = Set.new

      user_ingredients.each do |ingredient|
        matching_recipes = ingredient.recipes # each ingredient should be involved in one or more recipes
      end
    end
  end



  def roulette
    # have to fetch cookie

    if hasModifiedPantry == false
      # use contents
      # render anthony's page
      setHasModifiedToTrue
      if listOfRecipes.length > 0
        @recipe_name = listOfRecipes[0]
      else
        render "sorry"
    else # hasModifiedPantry == True

      # query database for a list of recipes that differ
      # list of ingredients of user
      user_ingredients = User.ingredients # list of user ingredients

      list_of_recipes = Set.new
      user_ingredients.each do |ingredient|
        matching_recipes = ingredient.recipes # each ingredient should be related to multiple recipes

        
      end

    end
  end

  private

  # set has_modified_pantry cookie to false
  def update_has_modified_pantry
  end

  def render_appropriate_page(list_of_recipe_names)
    if list_of_recipe_names.length > 0
      @recipe_name = list_of_recipe_names[0]
    else
      render "sorry"
    end
  end

end
