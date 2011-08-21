When /^I execute "([^\"]*)"$/ do |script|
  page.driver.browser.execute_script(script)
end

When /I sleep|wait (\d+) seconds?/ do |arg1|
  sleep arg1.to_i
end
