Given /^I have syntax error in my  files$/ do
  $stdout = StringIO.new
end

When /^I run the Precommit check with on invalid files$/ do
  precommit = GitHooks::Helper::Precommit.new
  spechelper = GitHooks::Helper::Test.new
  spechelper.create_git_branch
  git = GitHooks::Git::Info.new
  dest_dir = "#{git.get_root()}/rspec_test"
  curr_dir = File.dirname(__FILE__)

  src  = ["#{curr_dir}/invalid_node.pp","#{curr_dir}/invalid_template.erb"]
  dest = ["#{dest_dir}/invalid_node.pp","#{dest_dir}/invalid_template.erb"]
  
  spechelper.copy_file(src,dest)
  spechelper.add_to_git
  
  @output = precommit.run
  
  spechelper.delete_file
  spechelper.delete_git_branch
  
end

Then /^I should see error displayed on screen$/ do
  expect($stdout.string).to include('error')
end

And /^erroneous run must return :(.*)$/ do | symbol |
   expect(@output).to eq(symbol.to_sym )
   $stdout = STDOUT  
end