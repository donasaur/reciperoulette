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
Ingredient.create({name: 'flour'})

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
                        ingredients: Ingredient.where(:name => ['egg', 'rice', 'ham', 'soy sauce', 'butter']),
                        instructions: "Heat a wok or a small, heavy skillet over high heat. Add 1 1/2 tablespoons oil, swirl to coat the pan.\n
                                Add eggs and scramble them. As soon as there is no more freely running egg, turn them out into a bowl and break them into small bits. They should be soft and a bit runny -- not brown.\n
                                Heat the wok or a large skillet and add 2 tablespoon oil to coat.\n
                                Add the rice and toss briskly to coat and separate each grain, about 2 to 3 minutes.\n
                                Add the ham and peas.\n
                                Toss to mix in the ingredients and allow the mixture to heat through, about 30 seconds.\n
                                Return the eggs to the pan and toss to combine.\n
                                Season with salt, scallions and peanuts, tossing another 5 to 10 seconds to let the eggs get hot.")

recipe_six = Recipe.create(name: 'Avocado BLT',
                        cook_time: 5,
                        prep_time: 10,
                        tags: Tag.where(name: ['breakfast']),
                        image: File.new("app/assets/images/Avocado_BLT.jpg"),
                        ingredients: Ingredient.where(:name => ['avocado', 'bacon', 'lettuce', 'tomato', 'bread']),
                        instructions: "Toast the bread to your liking.\n
                                Build sandwich by adding mayo and layers of bacon and lettuce to one slice of toasted bread.\n
                                Top with another slice of bread with mayo and layer with half the avocado and tomato slices'.\n
                                Season with salt and pepper, and cover with the last slice of toasted bread.\n
                                Tip: prep the tomato, avocado and lettuce leaves while the bread is toasting and the bacon is cooking.")

recipe_six = Recipe.create(name: 'Mashed Potatoes',
                        cook_time: 10,
                        prep_time: 20,
                        tags: Tag.where(name: ['lunch', 'dinner']),
                        image: File.new("app/assets/images/Mashed_Potatoes.jpg"),
                        ingredients: Ingredient.where(:name => ['butter', 'potato']),
                        instructions: "Place the peeled and cut potatoes into a medium saucepan. Add cold water to the pan until the potatoes are covered by at least an inch. Add a half teaspoon of salt to the water. Turn the heat on to high, and bring the water to a boil. Reduce the heat to low to maintain a simmer, and cover. Cook for 15 to 20 minutes, or until you can easily poke through them with a fork.\n
                                While the potatoes are cooking, melt the butter and warm the cream. You can heat them together in a pan on the stove or in the microwave.\n
                                When the potatoes are done, drain the water and place the steaming hot potatoes into a large bowl. Pour the heated cream and melted butter over the potatoes. Mash the potatoes with a potato masher. Then use a strong wooden spoon (a metal spoon might bend) to beat further. Add milk and beat until the mashed potatoes are smooth. Don't over-beat the potatoes or the mashed potatoes will end up gluey.
                                Add salt and pepper to taste.")

recipe_six = Recipe.create(name: 'Pulled Pork Sandwhich',
                        cook_time: 10,
                        prep_time: 20,
                        tags: Tag.where(name: ['lunch', 'dinner']),
                        image: File.new("app/assets/images/Pulled_Pork_Sandwhich.jpg"),
                        ingredients: Ingredient.where(:name => ['pork', 'bbq sauce', 'lettuce', 'carrot']),
                        instructions: "Combine 1 tablespoon brown sugar, the paprika, mustard powder, cumin, 2 teaspoons salt and 1/2 teaspoon pepper in a small bowl. Rub the spice mixture all over the pork.\n
                                Heat the vegetable oil in a large skillet; add the pork and cook, turning, until browned on all sides, 5 minutes. Remove the pork and transfer to a plate; whisk 3/4 cup water into the drippings in the skillet. Transfer the liquid to a 5-to-6-quart slow cooker.\n
                                Add the vinegar, tomato paste, the remaining 2 tablespoons brown sugar and 2 cups water to the slow cooker and whisk to combine. Add the pork, cover and cook on low, 8 hours.\n
                                Remove the pork and transfer to a cutting board. Strain the liquid into a saucepan, bring to a boil and cook until reduced by half, about 10 minutes. Season with salt. Roughly chop the pork and mix in a bowl with 1 cup of the reduced cooking liquid, and salt and vinegar to taste. Serve on buns with barbecue sauce and coleslaw.")

recipe_seven = Recipe.create(name: "Chicken Pot Pie",
                        cook_time: 30,
                        prep_time: 20,
                        tags: Tag.where(name: ['lunch', 'dinner']),
                        image: File.new("app/assets/images/Chicken_Pot_Pie.jpg"),
                        ingredients: Ingredient.where(:name => ['chicken breast', 'flour', 'peas', 'carrot', 'onion', 'butter', 'salt', 'pepper', 'celery']),
                        instructions: "Preheat oven to 400°F.\n
                                Saute onion, celery, carrots and potatoes in margarine for 10 minutes.\n
                                Add flour to sauteed mixture, stirring well, cook one minute stirring constantly.\n
                                Combine broth and half and half.\n
                                Gradually stir into vegetable mixture.\n
                                Cook over medium heat stirring constantly until thickened and bubbly.\n
                                Stir in salt and pepper; add chicken and stir well.\n
                                Pour into shallow 2 quart casserole dish and top with pie shells.\n
                                Cut slits to allow steam to escape.\n
                                Bake for 40-50 minutes or until pastry is golden brown and filling is bubbly and cooked through.")

recipe_eight = Recipe.create(name: "Chicken and Dumpling Soup",
                        cook_time: 20,
                        prep_time: 15,
                        tags: Tag.where(name: ['breakfast', 'lunch', 'dinner']),
                        image: File.new("app/assets/images/Chicken_and_Dumpling_Soup.jpg"),
                        ingredients: Ingredient.where(:name => ['flour', 'salt', 'water', 'carrot', 'celery', 'garlic', 'basil', 'milk', 'chicken breast']),
                        instructions: "Start out by putting together the dough for your dumplings. Mix together the flour, salt and baking powder. Then slowly add in your ice water. Keep adding it in until you have enough to form a nice dough ball. Knead your dough for about 5 minutes and then set it the side and let it rest while you work on the other end of the soup. \n
                                In a large pot add together your stock, chicken, carrots, celery, garlic, basil, oregano, and celery salt. Heat it up on medium heat and let the chicken cook through. When the chicken is cooked, remove it and set it to the side.\n
                                Now grab up your dough and roll it out about 1/4 thick with your rolling pin. Cut it into small squares and place them in your hot broth. As they cook up, they will rise to the top of the broth.\n
                                While your dumplings are cooking, go ahead and shred your chicken up. Add it to your soup. Last but not least, add in the half and half and give it a couple swirls around the pan to incorporate everything together.")



