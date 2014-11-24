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

  def percentage_of_ingredients_matched(recipe, user = current_user)
    num_of_ingredients_matched = (recipe.ingredients & get_active_ingredients(user)).length
    percent_of_ingredients_matched = num_of_ingredients_matched.fdiv(recipe.ingredients.length) * 100
  end

  # given a recipe, returns a percent of ingredients matched
  def progress_bar_percentage(recipe, user = current_user)
    percent_of_ingredients_matched = percentage_of_ingredients_matched(recipe, user)
    case percent_of_ingredients_matched
    when 0..10
      return "#A00000"
    when 10..20
      return "#FF0000"
    when 20..30
      return "#FF6600"
    when 30..40
      return "#FF9900"
    when 40..50
      return "#FFCC00"
    when 50..60
      return "#FFFF00"
    when 60..70
      return "#CCFF00"
    when 70..80
      return "#99FF00"  
    when 80..90
      return "#66CC00"
    else
      return "#339900"
    end
  end
end
