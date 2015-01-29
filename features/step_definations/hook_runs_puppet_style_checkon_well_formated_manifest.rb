Given /^I have a well formated manifest$/ do
  @bad_manifest = ["#{File.dirname(__FILE__)}/well_formated_manifest.pp"]
end

When /^I run puppet style check on well manifest$/ do
  run_style_validator = GitHooks::Checks::Puppet_style.new
  @output = run_style_validator.check_on(@bad_manifest)
end

Then /^I should not see any response$/ do
  expect(@output[:msg].first).to eq("")
end

And /^Success status should be (.*)$/ do | status |
 expect(@output[:status].first).to eq(status.to_i)
end
