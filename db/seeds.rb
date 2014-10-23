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
ingredient_one = Ingredient.create({name: 'nitrogen'})
ingredient_two = Ingredient.create({name: 'oxygen'})

# associate those ingredients with a created recipe
recipe = Recipe.create({name: 'nitrousoxide',
                        ingredients: Ingredient.where(:name => ['nitrogen', 'oxygen'])})

# make this created recipe a saved recipe for the seed user
seed_user.recipes << recipe

# add ingredients to the user's pantry
seed_user.pantry.ingredients << Ingredient.where(:name => ['nitrogen', 'oxygen'])

# create two more ingredients
ingredient_three = Ingredient.create({name: 'carbon'})
ingredient_four = Ingredient.create({name: 'hydrogen'})

# add another recipe and associate ingredients with it
recipe_two = Recipe.create(name: 'caffeine', ingredients: Ingredient.where(:name => ['carbon', 'nitrogen', 'oxygen', 'hydrogen']))
