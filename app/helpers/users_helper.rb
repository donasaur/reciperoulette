module UsersHelper

  # given a recipe, returns a percent of ingredients matched
  def progress_bar_percentage(recipe)
    num_of_ingredients_matched = (recipe.ingredients & current_user.pantry.ingredients).length
    percent_of_ingredients_matched = num_of_ingredients_matched.fdiv(recipe.ingredients.length) * 100
  end
end
