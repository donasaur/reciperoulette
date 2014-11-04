module UsersHelper

  # given a recipe, returns a percent of ingredients matched
  def progress_bar_percentage(recipe)
    num_of_ingredients_matched = (recipe.ingredients & current_user.pantry.ingredients).length
    percent_of_ingredients_matched = num_of_ingredients_matched.fdiv(recipe.ingredients.length) * 100
    case percent_of_ingredients_matched
    when 0..25
      return "rgba(255,0,0,0.3)"
    when 25..50
      return "rgba(255,165,0,0.3)"
    when 50..75
      return "rgba(255,255,0,0.3)"
    when 75..100
      return "rgba(0,100,0,0.3)"
    end
  end
end
