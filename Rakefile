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
 sh "rm -f #{curr_dir}/.git/hooks/helper/test.rb "
 puts "Installed Precommit hook for puppet"
end

desc "Default task"
task :default => [:install_gems,:run_tests]
