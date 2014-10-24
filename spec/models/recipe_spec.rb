require 'rails_helper'

RSpec.describe Recipe, :type => :model do
  before(:each) do
    @recipe = Recipe.new(name: "soup")
  end

  it "should have to_s equal to the name of the Recipe" do
    expect(@recipe.to_s).to eq @recipe.name
  end

  it "cannot have a blank name" do
    recipe = Recipe.new(name: "")
    expect(recipe.save).to eq false
  end

  it "should have a unique name" do
    recipe1 = Recipe.create(name: "chicken")
    recipe2 = Recipe.new(name: "chicken")
    expect(recipe2.save).to eq false
  end

  it "should properly handle creation of multiple recipes (3)" do
    recipe1 = Recipe.create(name: "chicken noodle soup")
    recipe2 = Recipe.create(name: "split pea soup")
    recipe3 = Recipe.create(name: "vegetable garden soup")
    expect(Recipe.all.length).to eq 3
  end

  it "should be able to have instructions, prep_time, cook_time, and description" do
    recipe = Recipe.create(name: "chicken noodle soup", tag: "chicken", prep_time: 10, cook_time: 20, description: "Yummy soup")
    r = Recipe.first
    expect(Recipe.all.length).to eq 1
    expect(r.prep_time).to eq 10
    expect(r.cook_time).to eq 20
    expect(r.description).to eq "Yummy soup"
  end

end

