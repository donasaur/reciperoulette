require 'rails_helper'

RSpec.describe Recipe, :type => :model do
  before(:each) do
    DatabaseCleaner.strategy = :transaction
    DatabaseCleaner.clean_with(:truncation)
    @recipe = Recipe.create(name: "soup", instructions: 'a', prep_time: 5, cook_time:5)
  end

  it "should have to_s equal to the name of the Recipe" do
    expect(@recipe.to_s).to eq @recipe.name
  end

  it "cannot have a blank name" do
    recipe = Recipe.new(name: "")
    expect(recipe.save).to eq false
  end

  it "should have a unique name" do
    recipe1 = Recipe.create(name: "chicken", instructions: 'a', prep_time: 5, cook_time:5)
    recipe2 = Recipe.new(name: "chicken", instructions: 'a', prep_time: 5, cook_time:5)
    expect(recipe2.save).to eq false
  end

  it "should properly handle creation of multiple recipes (3)" do
    recipe1 = Recipe.create(name: "chicken noodle soup", instructions: 'a', prep_time: 5, cook_time:5)
    recipe2 = Recipe.create(name: "split pea soup", instructions: 'a', prep_time: 5, cook_time:5)
    recipe3 = Recipe.create(name: "vegetable garden soup", instructions: 'a', prep_time: 5, cook_time:5)
    expect(Recipe.all.length).to eq 4
  end

  it "should be able to have instructions, prep_time, cook_time" do
    recipe = Recipe.create(name: "chicken noodle soup", instructions: 'a', prep_time: 10, cook_time:20)
    r = Recipe.where(name: "chicken noodle soup").first
    expect(Recipe.all.length).to eq 2
    expect(r.prep_time).to eq 10
    expect(r.cook_time).to eq 20
    expect(r.instructions).to eq "a"
  end

  it "should show the correct recipe average rating", :type => "rating" do
    recipe_of_interest = Recipe.all.first
    rating = Rating.create(recipe_id: recipe_of_interest.id, user_id: 1, score: 4)
    rating = Rating.create(recipe_id: recipe_of_interest.id, user_id: 2, score: 2)
    rating = Rating.create(recipe_id: recipe_of_interest.id, user_id: 3, score: 0)
    expect(recipe_of_interest.average_rating).to eq 2
  end



end

