#encoding: utf-8
Feature: Showcase the simplest possible Cucumber scenario
  In order to verify that cucumber is installed and configured correctly
  As an aspiring BDD fanatic 
  I should be able to run this scenario and see that the steps pass (green like a cuke)
 
  Scenario: Tutorial scenario for Cutting vegetables
    Given a cucumber that is 30 cm long
    When I cut it in halves
    Then I have two cucumbers
    And both are 15 cm long

  Scenario: Be able to create a user
    Given the default user
    Then the default user exists

  Scenario: Check user's email
    Given the default user
      And the default user exists
    Then I can check its email