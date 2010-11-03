Feature: Component with persistence
  In order to value
  As a role
  I want feature

@javascript
Scenario: ComponentWithPersistence should behave
  When I go to the ComponentWithPersistence test page
  Then I should see "Default title"
  
  When I press "Change title"
  And I go to the ComponentWithPersistence test page
  Then I should see "New title"
  But I should not see "Default title"
  
  When I press "Set original title"
  And I go to the ComponentWithPersistence test page
  Then I should see "Default title"
  But I should not see "New title"

