Feature: Telling a nice Fable as a Story

  Scenario: The donkey and the Wolf
    Given there is the donkey and a wolf
    And the donkey has a splinter in his foot
    When the miserable animal meets the wolf
    And he whines:
    """
    Hey look what a poor animal I am.
    I have got a splinter in my foot.
    """
    And the wolf answers:
    """
    Truly, you are. And you make me feel sorry.
    """
    And he continues:
    """
    I feel beholden to relieve your pain.
    """
    And he tears apart the miserable animal
    Then the donkey should have no pain
    And no pitiful animal exists
    But now the donkey is not alive anymore
