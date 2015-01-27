Given /^I have a valid manifests$/ do
  @current_dir = File.dirname(__FILE__)
  @validator = GitHooks::Checks::Puppet_syntax.new
end

When /^I run check on valid manifests$/ do
  test_file = ["#{@current_dir}/valid_node.pp"]
  @output = @validator.check_on(:manifest,test_file)
end

Then /^I must see no output$/ do
  @output[:msg].each { | msg | expect(msg).to eq("") }
end
