Then /^button "([^\"]*)" should be disabled$/ do |arg1|
  pending
end

When /^I press tool "([^"]*)"$/ do |tool|
  id = page.driver.browser.execute_script(<<-JS)
    return Ext.ComponentQuery.query('tool[type="gear"]')[0].getId();
  JS

  find("##{id} img").click
end

When /^I wait for response from server$/ do
  page.wait_until{ page.driver.browser.execute_script("return !Netzke.ajaxIsLoading()") }
end
