# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

u = User.create!(email: "a@gmail.com", password: "devisepassword")
Pantry.create(user_id: u.id)
Ingredient.create(name: "Chicken")
Ingredient.create(name: "Broccoli")
