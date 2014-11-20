module RecipesHelper

  def recipe_ingredient_in_pantry(ingredient, user = current_user)
    active_ingredients = get_active_ingredients(user)
    if active_ingredients.include?(ingredient)
      return "green"
    else 
      return "black"
    end
  end

end
