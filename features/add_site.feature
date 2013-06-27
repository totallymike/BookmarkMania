Feature: Bookmark storage
  Scenario: Enter URL and Tags and the bookmark is created
    Given I visit the home page
    And I fill in "url" with "http://www.example.com/page1"
    And I fill in "tags" with "foo, bar"
    When I press "Save"
    Then I should be on the bookmark page
    And I should see "http://www.example.com/page1"