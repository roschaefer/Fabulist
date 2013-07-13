Feature: Use of decorators to tag objects

  Scenario: Dagobert Duck
    Given there is a rich duck called "Dagobert"
    And he has three grandchildren called "Tic" "Tric" and "Trac"
    When the rich duck calls "Tic"
    Then Tic appears
    And Tic is his grandchild
