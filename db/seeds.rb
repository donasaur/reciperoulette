# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

# Seed a test user with some stuff
seed_user = User.new
seed_user.email = 'test@example.com'
seed_user.password = 'password'
seed_user.password_confirmation = 'password'
seed_user.save

ingredient_one = Ingredient.create({name: 'nitrogen'})
ingredient_two = Ingredient.create({name: 'oxygen'})
recipe = Recipe.create({name: 'nitrousoxide',
                        ingredients: Ingredient.where(:name => ['nitrogen', 'oxygen'])})
seed_user.recipes << recipe

seed_user.pantry.ingredients << Ingredient.where(:name => ['nitrogen', 'oxygen'])

ingredient_three = Ingredient.create({name: 'carbon'})
ingredient_four = Ingredient.create({name: 'hydrogen'})

recipe_two = Recipe.create(name: 'caffeine', ingredients: Ingredient.where(:name => ['carbon', 'nitrogen', 'oxygen', 'hydrogen']))
