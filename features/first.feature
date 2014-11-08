#encoding: utf-8
Feature: Showcase the simplest possible Cucumber scenario
  In order to verify that cucumber is installed and configured correctly
  As an aspiring BDD fanatic
  I should be able to run this scenario and see that the steps pass (green like a cuke)

# Any scenario that is on a page will check for the header

  Scenario: Be able to create a user
    Given the default user
    Then the default user exists

  Scenario: Check user's email
    Given the default user
      And the default user exists
    Then I can check its email

  Scenario: Create a user and check Dashboard elements
    Given the default user
    Given I am on users/dashboard
    Then I follow Login
    And I fill in user_email with test@helper.com
    And I fill in user_password with password
    And I press Log in
    Then I should see Welcome to your dashboard, test@helper.com!
    And I should see Recipe Roulette
    And I should see Recipe Filters
    And I should see Your Pantry
    And I should see Your Saved Recipes
    And I should see Ingredient name
    And I should find the button: Play Roulette
    And I should find the button: Add Ingredient
    And I should find the checked box: breakfast
    And I should find the checked box: lunch
    And I should find the checked box: dinner


  Scenario: Adding ingredient to pantry
    Given the default user
    Given I am on users/dashboard
    Then I follow Login
    And I fill in user_email with test@helper.com
    And I fill in user_password with password
    And I press Log in
    When I fill in ingredient_name with egg
    And I press Add Ingredient
    Then I should see egg

  Scenario: User can play roulette from dashboard and check contents of Roulette page
    Given the default user
    Given I am on users/dashboard
    Then I follow Login
    And I fill in user_email with test@helper.com
    And I fill in user_password with password
    And I press Log in
    Then I should see Welcome
    And I should see Recipe Roulette
    When I press Play Roulette
    Then I should find the button: Skip
    And I should find the button: Block

  Scenario: User can view the first recipe for Roast Chicken
    Given the default user
    Given one default recipe for Roast Chicken
    Given I am on recipes/1
    Then I should see Roast Chicken
    And I should see Recipe Roulette

  Scenario: User can view fields in Roast Chicken Recipe
    Given the default user
    Given one default recipe for Roast Chicken
    Given I am on recipes/1
    Then I should see Roast Chicken
    And I should see Prep Time:
    And I should see 20 min
    And I should see Prep Time:
    And I should see 90 min
    And I should see Instructions
    And I should see 400 degrees
    And I should see Ingredients
    And I should find the button: Save
    And I should find the button: Block

  Scenario: User can view the Block and Save buttons on recipe page
    Given the default user
    Given one default recipe for Roast Chicken
    Given I am on recipes/1
    And I should find the button: Block
    And I should find the button: Save

  Scenario: User can save a recipe
    Given the default user
    Given one default recipe for Roast Chicken
    Given I am on users/dashboard
    Then I follow Login
    And I fill in user_email with test@helper.com
    And I fill in user_password with password
    And I press Log in
    Then I should find a link to test@helper.com
    Given user has a saved recipe



