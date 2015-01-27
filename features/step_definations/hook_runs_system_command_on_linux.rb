
Given /^(.*) supports (.*)$/ do | os,command |
  @os = os
  @sys_command = GitHooks::System::Command.new()
end

When /^I pass on  a system command (.*)$/ do | command |
  @output = @sys_command.execute(command)
end

Then /^I should see a (.*) with (.*)$/ do | result,status |
 expect(@output[:msg]).to eq([result])
 expect(@output[:status]).to eq([status.to_i])
end
