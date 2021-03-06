Feature: Commit
    In order to manage commits
    As an API user
    I need to be able to interact with the git commits

Scenario: Commit
    Given I am in a folder
    And I init the repository
    And I add a file named "first-file"
    And I add to the repository "first-file"
    When I commit with message "first-commit"
    And I get the last commit
    Then the commit should have "0" parent
    Then the commit message should equal "first-commit"
    And I add a file named "second-file"
    And I add to the repository "second-file"
    When I commit with message "second-commit"
    And I get the last commit
    Then the commit should have "1" parent
    Then the commit message should equal "second-commit"

Scenario: Multiple Parents
    Given I am in a folder
    And I init the repository
    And I add a file named "first-file"
    And I add to the repository "first-file"
    And I commit with message "first-commit"
    Then I create the branch "branch2" from "master"
    And I checkout "branch2"
    And I add a file named "second-file"
    And I add to the repository "second-file"
    And I commit with message "second-commit"
    And I checkout "master"
    And I add a file named "third-file"
    And I add to the repository "third-file"
    And I commit with message "third-commit"
    Then I merge "branch2"
    And I get the last commit
    Then the commit should have "2" parent

Scenario: Multiline Commit message
    Given I am in a folder
    And I init the repository
    And I add a file named "first-file"
    And I add to the repository "first-file"
    And I commit with message:
        """
        This is the short message
        Lorem ipsum dolor sit amet, consetetur sadipscing elitr,
        sed diam nonumy eirmod tempor invidunt ut labore et dolore
        magna aliquyam erat, sed diam voluptua. At vero eos et accusam
        et justo duo dolores et ea rebum.
        """
    And I get the last commit
    Then the commit message should equal "This is the short message"
    And the short commit message should equal "This is the short message"
    And the full commit message should equal:
        """
        This is the short message
        Lorem ipsum dolor sit amet, consetetur sadipscing elitr,
        sed diam nonumy eirmod tempor invidunt ut labore et dolore
        magna aliquyam erat, sed diam voluptua. At vero eos et accusam
        et justo duo dolores et ea rebum.
        """