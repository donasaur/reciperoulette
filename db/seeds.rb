# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

u = User.create(email: "a@gmail.com", password: "devisepassword")
p = Pantry.create(user_id: u.id)
r1 = Recipe.create(name: "Yummy Chicken Broccoli")
r2 = Recipe.create(name: "Pizza")
i1 = Ingredient.create(name: "Chicken")
i2 = Ingredient.create(name: "Broccoli")
i3 = Ingredient.create(name: "Pepperoni")
i4 = Ingredient.create(name: "Bread")
i5 = Ingredient.create(name: "Cheese")

p.ingredients << i1
r1.ingredients << i1
r1.ingredients << i2
r2.ingredients << i3
r2.ingredients << i4
r2.ingredients << i5