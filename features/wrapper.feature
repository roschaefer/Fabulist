Feature: Using a wrapper to tag objects
  As a developer, whose objects lack some methods to properly identify them
  I want to put those objects into a wrapper
  I order to tag them with arbitrary attributes

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

  Scenario: The Lion and the Mouse
    Given the lion "Leo" is asleep in the shadow of a tree
    And the small mouse "Mickey" is romping about
    And the Leo catches Mickey
    When she pleads
    """
    Please, let me live. I will help you if you get into any trouble.
    """
    And Leo is laughing
    """
    You little fellow want to help me? I am far bigger and stronger than you!
    """
    But then Leo just leaves her alone, since the mouse wouldn't have fed him that much
    When Leo falls into a net trap some days later
    And he roars desperately
    Then Mickey comes to his aid
    And she gnaws the ropes until Leo is free
    And Leo thanks Mickey and they become best friends
    Then sometimes strength is not all, even a small friend can be of great benefit

