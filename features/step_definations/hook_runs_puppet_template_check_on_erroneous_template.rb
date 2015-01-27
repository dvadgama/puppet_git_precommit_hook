Given /^I have an invalid template$/ do
  @current_dir = File.dirname(__FILE__)
  @validator = GitHooks::Checks::Puppet_syntax.new
end

When /^I run check on invalid template$/ do
  test_file = ["#{@current_dir}/invalid_template.erb"]
  @output = @validator.check_on(:template,test_file)
end

Then /^I must see error message (.*)$/ do | response | 
  @output[:msg].each { |msg| expect(msg).to include("#{response}") }
end
