Feature: get gitinfo

Before running checks on  the system, I need to get the various git information 
e.g.
1) git root_dir : to test this, once we have the git root dir / working dire , I  test for existance of $root_dit/.git/config
2) git diff inex to minimize the run time and, only check newly added/modififed files 
3) and..so on 

Scenario: I want to get , tree hash
  Given I have a working git repository
  When I call get_head() function
  Then I should see the 40 character long SHA1 hash
 
Scenario: Get appropriate hash for the empty git tree
  Given I have an empty git repository
  When I execute git_empty_head() function 
  Then I should see the 40 character long "4b825dc642cb6eb9a060e54bf8d69288fbee4904" SHA1 hash
  
Scenario: get the newly added/copied/modififed file in git_empty
  Given I have added,copied or modified the file in repo 
  When I run git_files() function
  Then I should get the list of files