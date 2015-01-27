
Given /^I have added,copied or modified the file in repo$/ do
   @repository = GitHooks::Git::Info.new
end

When /^I run git_files\(\) function$/ do
  @output = @repository.get_files()
end

Then /^I should get the list of files$/ do
  @output.each { | file | expect(File).to exist(file) }
end