Feature: Using a wrapper to tag objects

  Scenario: The one smart and the nine silly wolves
    Given there is 1 smart wolf and 9 silly wolves
    And they have stolen 10 sheeps
    When the smart wolf suggest to equitably share the loot
    And the others ask how to do that
    And the smart suggests to divide by 10
    And he adds 9 wolves to one sheep
    And he adds himself to 9 sheeps
    Then both results are equal to 10
    And he asks: "This is twice divided by 10, isn't it?"
    Then he other silly wolves answer "That's right, exactly"

