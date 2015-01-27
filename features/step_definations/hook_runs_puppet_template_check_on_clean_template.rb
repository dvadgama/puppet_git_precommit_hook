Given /^I have a valid template$/ do
  @current_dir = File.dirname(__FILE__)
  @validator = GitHooks::Checks::Puppet_syntax.new
end

When /^I run check on valid template$/ do
  test_file = ["#{@current_dir}/valid_template.erb"]
  @output = @validator.check_on(:template,test_file)
end

Then /^I must see success message (.*)$/ do | response | 
  @output[:msg].each { |msg | expect(msg).to eq("#{response}") }
end
