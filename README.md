# puppet_git_precommit_hook
Precommit Git hook for puppet syntax check written in ruby

Rake Default task is there to Install Gems & Run Tests

$rake

To install pre-commit hook, execute 

$rake install_precommit_hook

# To Do
1) Refactor Tests

2) Add check for style with puppet-lint

3) update rake :install_precommit_hook  to take path of another repository as a arg

e.g. $rake :install_precommit_hook /for/this/puppet/module/
