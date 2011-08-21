Feature: Configurable
  In order to value
  As a role
  I want feature

@javascript
Scenario: Configurable components should remember the configuration values they receive from the user
  Given I am on the SimpleConfigurableComponent test page
  When I press tool "gear"
  And I wait for response from server
  And I fill in "Title" with "New title"
  And I fill in "Html" with "Some HTML here"
  And I press "Ok"

  And I go to the SimpleConfigurableComponent test page
  Then I should see "New title"
  And I should see "Some HTML here"
