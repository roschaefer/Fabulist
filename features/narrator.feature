Feature: An instance variable as a representation of the narrator

  Scenario: Buy last coffee
    Given I am tired
    And we have a coffe machine in the hall
    And it has 1 coffee left
    When I insert 1$ into the machine
    When I press its coffee button
    Then it will serve me a coffe
    And it has no coffees left
