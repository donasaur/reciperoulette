require 'rails_helper'

RSpec.describe Pantry, :type => :model do
  before :each do
    @u = User.create(email: "obama@whitehouse.gov", password: 'password', password_confirmation: 'password')
    u_id = @u.id
    @p = Pantry.new(user_id: u_id)
  end

  it "cannot exist without a user" do
    p = Pantry.new(user_id: nil)
    expect(p.save).to eq false
  end

  it "should be able to be created when tied to a user" do
    expect(@p.save).to eq true
  end

  it "may have ingredients" do
    i = Ingredient.create(name: "chicken")
    @p.ingredient_ids = @p.ingredient_ids << i.id
    expect(@p.ingredient_ids.length).to eq 1
  end

  it "may not have repeated ingredients in the pantry" do
    i = Ingredient.create(name: "chicken")
    @p.ingredient_ids = @p.ingredient_ids << i.id
    @p.ingredient_ids = @p.ingredient_ids << i.id
    expect(@p.ingredient_ids.length).to eq 1
  end

end
