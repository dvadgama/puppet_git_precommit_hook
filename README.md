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


#Note

This project is not to replace the easier shell/bash script availabe for such checks but, solely to improve on the ruby skills and, get hands on with BDD,Cucumber 7 RSpec.

I will try to update this project as frequent as possible with better Tests , ruby codes
