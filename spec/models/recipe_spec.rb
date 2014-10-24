require 'rails_helper'

RSpec.describe Recipe, :type => :model do
  before(:each) do
    @recipe = Recipe.new(name: "soup")
  end

  it "should have to_s equal to the name of the Recipe" do
    expect(@recipe.to_s).to eq @recipe.name
  end

end

