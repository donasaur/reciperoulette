class PantriesController < ApplicationController
  def update
    ingredient_ids = params["pantry"]["ingredient_ids"].map(&:to_i)
    puts "params ingredients ids"
    puts ingredient_ids
    @user = current_user
    @pantry = @user.pantry
    @pantry.ingredient_ids = @pantry.ingredient_ids - ingredient_ids
    puts "pantry ingredient ids"
    puts @pantry.ingredient_ids
    @pantry.save
    render "user/dashboard"
  end
end
