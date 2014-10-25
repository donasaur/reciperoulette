require 'rails_helper'

#RSpec.describe Ingredient, :type => :model do
#  pending "add some examples to (or delete) #{__FILE__}"
#end

describe "IngredientModel" do
  before(:each) do
    @ingredient = Ingredient.new(name: "salt")
  end

  it "should have to_s equal to the name of the Ingredient" do
    expect(@ingredient.to_s).to eq @ingredient.name
  end

  it "should not be able to create two identical ingredients" do
    i = Ingredient.create(name: "sugar")
    j = Ingredient.new(name: "sugar")
    expect(j.save).to eq false
  end

end