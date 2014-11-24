module RecipesHelper

  def recipe_ingredient_in_pantry(ingredient, user = current_user)
    if !user
      return "black"
    end
    active_ingredients = get_active_ingredients(user)
    if active_ingredients.include?(ingredient)
      return "green"
    else 
      return "black"
    end
  end

  def create_sample_recipe
    Ingredient.create({name: 'egg'})
    Ingredient.create({name: 'butter'})
    Ingredient.create({name: 'salt'})
    Ingredient.create({name: 'pepper'})

    recipe_two = Recipe.create({name: 'Scrambled Eggs',
                        cook_time: 5,
                        prep_time: 5,
                        tags: Tag.where(name: ['breakfast']),
                        image: File.new("app/assets/images/Scrambled_Eggs.jpg"),
                        ingredients: Ingredient.where(:name => ['egg', 'butter', 'salt', 'pepper']),
                        instructions: "Break eggs into a bowl.\n
                                Beat eggs until blended.\n
                                Heat butter in a large nonstick skillet over medium heat until hot.\n
                                Pour the eggs into the pan. As eggs begin to set, gently pull the eggs across the pan with a spatula. Continue to cook until thicken and no visible liquid remains.\n
                                Remove from heat, add salt and pepper to taste and serve."})
  end

end
