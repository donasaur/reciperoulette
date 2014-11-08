include Devise::TestHelpers
#encoding: utf-8
#First basic steps
Given(/^the default user$/) do
  @user = User.new(email: "test@helper.com", password: 'password', password_confirmation: 'password')
  @user.save
end

Given(/^an ingredient salt is the DB$/) do
  Ingredient.create(name:"salt")
end

Then(/^the default user exists$/) do
  expect(User.all).to  include(@user)
end

Then(/^I can check its email$/) do
  expect(@user.email).to eq "test@helper.com"
end

Given /^I am on(?: the)* (.+)$/ do |page_name|    # assign the variable in second parenthesis to page_name
  visit "#{page_name}"
end

Given(/^I am at root_path$/) do
  visit(root_path)
end

Then(/^I should find the button: (.*)$/) do |id|
  page.has_button?(id)
end

Given(/^one default recipe for Roast Chicken$/) do
  @recipe = Recipe.create({name: 'Roast Chicken',
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
end

Given(/^user has a saved recipe$/) do
  @user.recipes << @recipe
  expect(@user.recipes.length).to eq 1
end

Then(/^I should find a link to (.*?)$/) do |link|
  expect(page).to have_selector(:link, "#{link}")
end

Then(/^I should find the checked box: (.*?)$/) do |check|
  page.has_checked_field?(check)
end