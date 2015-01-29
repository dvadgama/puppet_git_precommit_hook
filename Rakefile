desc "Install Gems"
task :install_gems do
 sh "bundle install"
end

desc "Run tests" 
task :run_tests do
 sh "rspec --format doc"
 sh "cucumber"
end

desc "Install precommit hook"
task :install_precommit_hook do
 curr_dir = File.dirname(__FILE__)
 sh "cp -r #{curr_dir}/lib/hooks/* #{curr_dir}/.git/hooks/"
 sh "rm -f #{curr_dir}/.git/hooks/helper/test.rb"
 puts "Installed Precommit hook for puppet"
end

desc "Default task"
task :default => [:install_gems,:run_tests]

desc "Install Precommit hook to a different git repo"
task :install_precommit_hook_to, :other_git_repo do |t,args|
 curr_dir = File.dirname(__FILE__)
 sh "cp -r #{curr_dir}/lib/hooks/* #{args[:other_git_repo]}/.git/hooks"
 sh "rm -f  #{args[:other_git_repo]}/.git/hooks/helper/test.rb"
 puts "Installed Precommit hook for puppet at #{args[:other_git_repo]}"
end
