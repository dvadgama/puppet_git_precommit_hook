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
 sh "cp -r #{curr_dir}/hooks/lib/hooks/* #{curr_dir}/.git/hooks 2&>1 > /dev/null"
 sh "rm -f #{curr_dir}/.git/hooks/helper/test.rb 2&>1 > /dev/null"
 puts "Installed Precommit hook for puppet"
end

desc "Default task"
task :default => [:install_gems,:run_tests]
