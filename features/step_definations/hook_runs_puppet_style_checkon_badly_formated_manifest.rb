Given /^I have a badly formated manifest$/ do
  @bad_manifest = ["#{File.dirname(__FILE__)}/badly_formated_manifest.pp"]
end

When /^I run puppet style check on bad manifest$/ do
  run_style_validator = GitHooks::Checks::Puppet_style.new
  @output = run_style_validator.check_on(@bad_manifest)
end

Then /^I should see error in response$/ do
  expect(@output[:msg].first).to match(/ERROR/)
end

And /^Error status should be (.*)$/ do | status |
 expect(@output[:status].first).to eq(status.to_i)
end
