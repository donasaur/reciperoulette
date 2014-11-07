include Devise::TestHelpers

#encoding: utf-8
#Tutorial Scenario steps
Given(/^a cucumber that is (\d+) cm long$/) do |length|
  @cucumber = {:color => 'green', :length => length.to_i}
end

When(/^I cut it in halves$/) do
  @choppedCucumbers = [
    {:color => @cucumber[:color], :length => @cucumber[:length] / 2},
    {:color => @cucumber[:color], :length => @cucumber[:length] / 2}
  ]
end

Then(/^I have two cucumbers$/) do
  expect(@choppedCucumbers.length).to eq 2
end

Then(/^both are (\d+) cm long$/) do |length|
  @choppedCucumbers.each do |cuke|
    expect(cuke[:length]).to eq length.to_i
  end
end

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
