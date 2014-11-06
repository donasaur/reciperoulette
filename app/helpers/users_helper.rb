module UsersHelper

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

  # given a recipe, returns a percent of ingredients matched
  def progress_bar_percentage(recipe)
    num_of_ingredients_matched = (recipe.ingredients & get_active_ingredients(current_user)).length
    percent_of_ingredients_matched = num_of_ingredients_matched.fdiv(recipe.ingredients.length) * 100
    case percent_of_ingredients_matched
    when 0..25
      return "rgba(255,0,0,0.7)"
    when 25..50
      return "rgba(255,165,0,0.7)"
    when 50..75
      return "rgba(255,255,0,0.7)"
    when 75..100
      return "rgba(0,100,0,0.7)"
    end
  end
end
