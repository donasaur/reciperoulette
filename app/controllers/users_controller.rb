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

  # has_modified_pantry (cookie key) -> True/False
  # has_modified_pantry is set to T if they modified pantry
  # has_modified_pantry is set to F when they play roulette
  # list_of_recipe_names (cookie key) -> e.g. [bread, potato]
  # list_of_recipe_names is set to a list when they play roulette (can be empty)
  def roulette
    has_modified_pantry = read_has_modified_pantry_cookie
    list_of_recipe_names = read_list_of_recipe_names_cookie

    if has_modified_pantry == false
      render_appropriate_page(list_of_recipe_names)
    else # has_modified_pantry == true, or has_modified_pantry is nil (should not be nil)
      list_of_recipe_names = gather_user_recipe_names
      list_of_recipe_names.shuffle! # randomize names!

      update_has_modified_pantry_cookie
      update_list_of_recipe_names_cookie(list_of_recipe_names)

      render_appropriate_page(list_of_recipe_names)
    end
  end

  private
    def read_has_modified_pantry_cookie
      if cookies.permanent[:has_modified_pantry] == "false"
        false
      elsif cookies.permanent[:has_modified_pantry] == "true"
        true
      else # cookies.permanent[:has_modified_pantry] is nil
        nil
      end
    end

    def read_list_of_recipe_names_cookie
      recipe_names_list_in_cookie = cookies.permanent[:list_of_recipe_names]
      if recipe_names_list_in_cookie
        JSON.parse(recipe_names_list_in_cookie)
      else
        []
      end
    end

    # set has_modified_pantry cookie to false
    def update_has_modified_pantry_cookie
      cookies.permanent[:has_modified_pantry] = "false"
    end

    # set list_of_recipe_names cookie to a list (possibly empty)
    def update_list_of_recipe_names_cookie(list_of_recipe_names)
      cookies.permanent[:list_of_recipe_names] = JSON.generate(list_of_recipe_names)
    end

    def render_appropriate_page(list_of_recipe_names)
      if list_of_recipe_names.length > 0
        @recipe_name = list_of_recipe_names[0]
      else
        render "sorry"
      end
    end

    def gather_user_recipe_names
      byebug
      user_ingredients = current_user.pantry.ingredients # list of ingredient objects
      recipe_search_results = Set.new

      user_ingredients.each do |ingredient|
        matching_recipes = ingredient.recipes # each ingredient should be involved in one or more recipes
        recipe_search_results.merge(matching_recipes)
      end

      # here, recipe_search_results is a list of relevant recipes
      list_of_recipe_names = recipe_search_results.map do |recipe|
        recipe.to_s
      end

      list_of_recipe_names # return list of recipe names
    end

end
