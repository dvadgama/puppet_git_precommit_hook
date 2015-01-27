#Scenario: When git is and empty tree
Given /^I have an empty git repository$/ do
  @repository = GitHooks::Git::Info.new
end

When /^I execute git_empty_head\(\) function$/ do
  @output = @repository.get_empty_head()
end

Then /^I should see the 40 character long "(.*)" SHA1 hash$/ do | sha1_string |
  expect(@output[:msg]).to eq([sha1_string])
end