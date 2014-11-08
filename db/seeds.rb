# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

# Seed a new test user (with devise support)
seed_user = User.new
seed_user.email = 'test@example.com'
seed_user.password = 'password'
seed_user.password_confirmation = 'password'
seed_user.save

# create two ingredients
# ingredient_one = Ingredient.create({name: 'nitrogen'})
# ingredient_two = Ingredient.create({name: 'oxygen'})

# associate those ingredients with a created recipe
# recipe = Recipe.create({name: 'nitrousoxide', ingredients: Ingredient.where(:name => ['nitrogen', 'oxygen'])})

# make this created recipe a saved recipe for the seed user
# seed_user.recipes << recipe

# add ingredients to the user's pantry
# seed_user.pantry.ingredients << Ingredient.where(:name => ['salt', 'pepper'])

# create two more ingredients
# ingredient_three = Ingredient.create({name: 'carbon'})
# ingredient_four = Ingredient.create({name: 'hydrogen'})

# add another recipe and associate ingredients with it
# recipe_two = Recipe.create(name: 'caffeine', ingredients: Ingredient.where(:name => ['carbon', 'nitrogen', 'oxygen', 'hydrogen']))

#create a ton of ingredients
Ingredient.create({name: 'salt'})
Ingredient.create({name: 'avocado'})
Ingredient.create({name: 'pepper'})
Ingredient.create({name: 'egg'})
Ingredient.create({name: 'rice'})
Ingredient.create({name: 'tomato'})
Ingredient.create({name: 'sour cream'})
Ingredient.create({name: 'spinach'})
Ingredient.create({name: 'bell pepper'})
Ingredient.create({name: 'ham'})
Ingredient.create({name: 'onion'})
Ingredient.create({name: 'carrot'})
Ingredient.create({name: 'sugar'})
Ingredient.create({name: 'cinnamon'})
Ingredient.create({name: 'ketchup'})
Ingredient.create({name: 'mustard'})
Ingredient.create({name: 'garlic'})
Ingredient.create({name: 'paprika'})
Ingredient.create({name: 'oregano'})
Ingredient.create({name: 'olive oil'})
Ingredient.create({name: 'vegetable oil'})
Ingredient.create({name: 'honey'})
Ingredient.create({name: 'soy sauce'})
Ingredient.create({name: 'tuna'})
Ingredient.create({name: 'basil'})
Ingredient.create({name: 'cheese'})
Ingredient.create({name: 'lemon'})
Ingredient.create({name: 'lime'})
Ingredient.create({name: 'chicken breast'})
Ingredient.create({name: 'ground beef'})
Ingredient.create({name: 'ground turkey'})
Ingredient.create({name: 'bacon'})
Ingredient.create({name: 'corn'})
Ingredient.create({name: 'butter'})
Ingredient.create({name: 'spaghetti'})
Ingredient.create({name: 'parsley'})
Ingredient.create({name: 'mayonnaise'})
Ingredient.create({name: 'cornstarch'})
Ingredient.create({name: 'lamb'})
Ingredient.create({name: 'steak'})
Ingredient.create({name: 'ginger'})
Ingredient.create({name: 'potato'})
Ingredient.create({name: 'thyme'})
Ingredient.create({name: 'milk'})
Ingredient.create({name: 'noodles'})
Ingredient.create({name: 'bay leaf'})
Ingredient.create({name: 'whole chicken'})
Ingredient.create({name: 'celery'})
Ingredient.create({name: 'tomato sauce'})
Ingredient.create({name: 'tortilla'})
Ingredient.create({name: 'syrup'})
Ingredient.create({name: 'bread'})
Ingredient.create({name: 'lettuce'})
Ingredient.create({name: 'pork'})
Ingredient.create({name: 'bbq sauce'})

# Add ingredient to user's pantry
seed_user.pantry.ingredients << Ingredient.where(:name => ['salt', 'pepper'])

# Tags
Tag.create({ name: 'breakfast' })
Tag.create({ name: 'lunch' })
Tag.create({ name: 'dinner' })


# Recipes
recipe_one = Recipe.create({name: 'Roast Chicken',
                        cook_time: 90,
                        prep_time:20,
                        tags: Tag.where(name: ['lunch', 'dinner']),
                        image: File.new("app/assets/images/Roast_Chicken.jpg"),
                        ingredients: Ingredient.where(:name => ['whole chicken', 'salt', 'pepper', 'paprika', 'onion', 'celery', 'carrot', 'garlic', 'bay leaf', 'olive oil']),
                        instructions: "Preheat oven to 400 degrees.\n
                                Remove and discard insides of chicken. Rinse chicken with cold water and pat dry. Trim any excess fat.\n
                                Combine salt, pepper, and paprika in a small bowl and sprinkle over chicken and into the cavity.\n
                                Place vegetables and bay leaf in body cavity. Tie ends of legs together with a cord (I have never done this and it still turns out fine). Lift wing tips up and over back; tuck under chicken.\n
                                Place chicken, breast side up, on a broiler pan (or on a rack inside another pan) coated with olive oil.\n
                                Bake at 400 degrees for one hour or until meat thermometer inserted into thigh registers 180 degrees.\n
                                Cover loosely with foil for about 10 minutes.\n
                                Remove vegetables from inside chicken and throw them away."})
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

recipe_three = Recipe.create({name: 'Spaghetti',
                        cook_time: 15,
                        prep_time: 5,
                        tags: Tag.where(name: ['lunch', 'dinner']),
                        image: File.new("app/assets/images/Spaghetti.jpg"),
                        ingredients: Ingredient.where(:name => ['spaghetti', 'tomato sauce', 'pepper', 'salt']),
                        instructions: "Bring a large pot of salted water to a rolling boil.\n
                                Add dry spaghetti noodles to the boiling water. Cook for 10 minutes, stirring occassionally.\n
                                Drain noodles and add to a sauce pan with the tomato sauce. Mix thoroughly and heat until hot.\n
                                Remove from heat and add salt and pepper to taste."})

recipe_four = Recipe.create({name: 'Chicken Fajitas',
                        cook_time: 10,
                        prep_time: 10,
                        tags: Tag.where(name: ['lunch', 'dinner']),
                        image: File.new("app/assets/images/Chicken_Fajitas.jpg"),
                        ingredients: Ingredient.where(:name => ['chicken breast', 'onion', 'bell pepper', 'salt', 'pepper']),
                        instructions: "Heat a grill pan to medium. Once hot, add the chicken breast pieces, season with salt and pepper, and cook undisturbed until well browned on the bottom, about 10 minutes.\n
                                Flip, season the second side with salt and pepper, and cook undisturbed until well browned on the bottom and cooked through, about 10 minutes more. Remove the chicken to a cutting board and let it rest while you prepare the remaining ingredients.\n
                                Place the bell pepper and onion in a medium bowl, drizzle with the remaining 1 tablespoon oil, season with salt and pepper, and toss to coat.\n
                                Place the vegetables on the grill pan in a single layer. Cook, stirring occasionally, until tender and slightly charred, about 10 minutes. Transfer the vegetables to a serving dish.\n
                                Slice the chicken against the grain into 1/2-inch-thick pieces and place in the serving dish with the vegetables."})

recipe_five = Recipe.create({name: 'Quesadilla',
                        cook_time: 5,
                        prep_time: 1,
                        tags: Tag.where(name: ['lunch', 'dinner']),
                        image: File.new("app/assets/images/Quesadilla.jpg"),
                        ingredients: Ingredient.where(:name => ['cheese', 'tortilla']),
                        instructions: "Heat a large pan on medium heat until hot.\n
                                Place one totilla down until warm and bubbly.\n
                                Flip the totilla over, and generously sprinkle cheese to cover it. Then place the second tortilla on top of the cheese.\n
                                When the bottom tortilla is golden brown, flip the quesdailla over and cook the second totilla utnil golden brown."})

recipe_six = Recipe.create({name: 'French Toast',
                        cook_time: 5,
                        prep_time: 10,
                        tags: Tag.where(name: ['breakfast']),
                        image: File.new("app/assets/images/French_Toast.jpg"),
                        ingredients: Ingredient.where(:name => ['egg', 'bread', 'butter', 'sugar', 'cinnamon', 'syrup', 'milk']),
                        instructions: "Beat egg, sugar and cinnamon in shallow dish. Stir in milk.\n
                                Dip bread in egg mixture, turning to coat both sides evenly.\n
                                Cook bread slices on lightly buttered nonstick griddle or skillet on medium heat until browned on both sides.\n
                                Serve with syrup."})

recipe_six = Recipe.create(name: 'Ham and Egg Fried Rice',
                        cook_time: 10,
                        prep_time: 20,
                        tags: Tag.where(name: ['lunch', 'dinner']),
                        image: File.new("app/assets/images/Ham_and_Egg_Fried_Rice.jpg"),
                        ingredients: Ingredient.where(:name => ['egg', 'rice', 'ham', 'soy sauce', 'butter']))

recipe_six = Recipe.create(name: 'Avocado BLT',
                        cook_time: 5,
                        prep_time: 10,
                        tags: Tag.where(name: ['breakfast']),
                        image: File.new("app/assets/images/Avocado_BLT.jpg"),
                        ingredients: Ingredient.where(:name => ['avocado', 'bacon', 'lettuce', 'tomato', 'bread']))

recipe_six = Recipe.create(name: 'Mashed Potatoes',
                        cook_time: 10,
                        prep_time: 20,
                        tags: Tag.where(name: ['lunch', 'dinner']),
                        image: File.new("app/assets/images/Mashed_Potatoes.jpg"),
                        ingredients: Ingredient.where(:name => ['butter', 'potato']))

recipe_six = Recipe.create(name: 'Pulled Pork Sandwhich',
                        cook_time: 10,
                        prep_time: 20,
                        tags: Tag.where(name: ['lunch', 'dinner']),
                        image: File.new("app/assets/images/Pulled_Pork_Sandwhich.jpg"),
                        ingredients: Ingredient.where(:name => ['pork', 'bbq sauce', 'lettuce', 'carrot']))

