#Scenario: when i have working git directory
Given /^I have a working git repository$/ do
  @repository = GitHooks::Git::Info.new
end

When /^I call get_head\(\) function$/ do
  @output = @repository.get_head()
end

Then /^I should see the (.*) character long SHA1 hash$/ do | sha1_length | 
  expect(@output[:msg].first.length).to be(sha1_length.to_i)
end
