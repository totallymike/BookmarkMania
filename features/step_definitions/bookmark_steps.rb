Given /the home page/ do
  visit(root_path)
end

When /^I fill in "(.*?)" with "(.*?)"$/ do |input, value|
  fill_in input, with: value
end

When /^I press "(.*?)"$/ do |button|
  click_button 'Save'
end

Then /the bookmark page$/ do
  pending
end

Then /^I should see "(.*?)$/ do |content|
  pending
end