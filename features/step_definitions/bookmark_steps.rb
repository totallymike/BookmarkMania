Given /the home page/ do
  visit(root_path)
end

When /^I fill in "(.*?)" with "(.*?)"$/ do |input, value|
  fill_in input, with: value
end

When /^I press "(.*?)"$/ do |button|
  click_button button
end

Then /the bookmark page$/ do
  current_path.should =~ %r{/bookmarks/\d+}
end

Then /^I should see "(.*?)"$/ do |content|
  page.should have_content content
end

Then /shortened URL$/ do
  find('a#short_url').text.should match %r[/\w{6}$]
end