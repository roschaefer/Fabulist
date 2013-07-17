Feature: Keep the narrator in mind
  As a developer
  I want to assign an instance variable with myself in the cucumber scenario
  In order to access it from everywhere in the step definitions

  Scenario: Buy last coffee
    Given I am tired
    And we have a coffee machine in the hall
    And it has 1 coffee left
    When I insert 1$ into the machine
    When I press its coffee button
    Then it will serve me a coffe
    And it has no coffees left
