Given /^I have not added any new files$/ do
  $stdout = StringIO.new
end

When /^I run the Precommit check on empty file list$/ do
  precommit = GitHooks::Helper::Precommit.new
  spechelper = GitHooks::Helper::Test.new

  spechelper.create_git_branch
  
  @output = precommit.run

  spechelper.delete_git_branch
  
end

Then /^I should not see anything on screen$/ do
  expect($stdout.string).to include('')
end

And /^empty run must return :(.*)$/ do | symbol |
   expect(@output).to eq(symbol.to_sym )
   $stdout = STDOUT
end
 
