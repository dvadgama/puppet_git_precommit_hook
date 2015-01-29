Given /^I have an ill formated manifest$/ do
  $stdout = StringIO.new
end

When /^I run puppet style check on ill manifest$/ do
  run_style_validator = GitHooks::Checks::Puppet_style.new
  spechelper = GitHooks::Helper::Test.new
  spechelper.create_git_branch
  git = GitHooks::Git::Info.new
  dest_dir = "#{git.get_root()}/rspec_test"
  curr_dir = File.dirname(__FILE__)
  
  src =  ["#{curr_dir}/ill_formated_manifest.pp"]
  dest = ["#{dest_dir}/ill_formated_manifest.pp"]
  
  spechelper.copy_file(src,dest)
  spechelper.add_to_git
  
  @output = run_style_validator.check_on(dest)
  
  spechelper.delete_file
  spechelper.delete_git_branch
end

Then /^ill formated check message should say (.*)/ do | what |
  expect(@output[:msg].first).to include(what)
end

And /^status should change to (.*)$/ do | status |
  expect(@output[:status].first).to eq(status.to_i)
end