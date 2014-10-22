# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

# Seed the first user with some stuff
first_user = User.find(1)
ingredient_one = Ingredient.create({name: 'nitrogen'})
ingredient_two = Ingredient.create({name: 'oxygen'})
recipe = Recipe.create({name: 'nitrousoxide',
                        ingredients: Ingredient.where(:name => ['nitrogen', 'oxygen'])})
first_user.recipes << recipe

first_user.pantry.ingredients << Ingredient.where(:name => ['nitrogen', 'oxygen'])

ingredient_three = Ingredient.create({name: 'carbon'})
ingredient_four = Ingredient.create({name: 'hydrogen'})

recipe_two = Recipe.create(name: 'caffeine', ingredients: Ingredient.where(:name => ['carbon', 'nitrogen', 'oxygen', 'hydrogen']))
