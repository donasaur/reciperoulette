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

# Add ingredient to user's pantry
seed_user.pantry.ingredients << Ingredient.where(:name => ['salt', 'pepper'])

# Recipes
recipe_one = Recipe.create({name: 'Roast_Chicken',
                        image: File.new("app/assets/images/Roast_Chicken.jpg"),
                        ingredients: Ingredient.where(:name => ['whole chicken', 'salt', 'pepper', 'paprika', 'onion', 'celery', 'carrot', 'garlic', 'bay leaf', 'olive oil'])})
recipe_two = Recipe.create(name: 'Scrambled_Eggs', 
                        image: File.new("app/assets/images/Scrambled_Eggs.jpg"),
                        ingredients: Ingredient.where(:name => ['egg', 'butter', 'salt', 'pepper']))

recipe_three = Recipe.create(name: 'Spaghetti', 
                        image: File.new("app/assets/images/Spaghetti.jpg"),
                        ingredients: Ingredient.where(:name => ['spaghetti', 'tomato sauce', 'pepper', 'salt']))

recipe_four = Recipe.create(name: 'Chicken_Fajitas', 
                        image: File.new("app/assets/images/Chicken_Fajitas.jpg"),
                        ingredients: Ingredient.where(:name => ['chicken breast', 'onion', 'bell pepper', 'salt', 'pepper']))

recipe_five = Recipe.create(name: 'Quesadilla', 
                        image: File.new("app/assets/images/Quesadilla.jpg"),
                        ingredients: Ingredient.where(:name => ['cheese', 'tortilla']))

recipe_six = Recipe.create(name: 'French_Toast', 
                        image: File.new("app/assets/images/French_Toast.jpg"),
                        ingredients: Ingredient.where(:name => ['egg', 'bread', 'butter', 'sugar', 'cinnamon', 'syrup']))






