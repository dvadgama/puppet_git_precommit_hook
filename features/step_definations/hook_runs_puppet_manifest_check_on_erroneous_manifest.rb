Given /^I have an invalid manifests$/ do
  @current_dir = File.dirname(__FILE__)
  @validator = GitHooks::Checks::Puppet_syntax.new
end

When /^I run check on invalid file$/ do
  test_file = ["#{@current_dir}/invalid_node.pp"]
  @output = @validator.check_on(:manifest,test_file)
end

Then /^I must see error$/ do
  @output[:msg].each { |msg | expect(msg).to match(/Error:/) }
end