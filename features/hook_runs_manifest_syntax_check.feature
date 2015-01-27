Feature: hook runs the syntax check on manifests

 I have the list of git files which are either added,copied or modified 
 and, now i want to run it through puppet parser validate  on a file 
 to ensure there are no syntax errors
 
Scenario: We have an invalid manifests
  Given I have an invalid manifests
  When I run check on invalid file
  Then I must see error
  
Scenario: We have a valid manifests 
  Given I have a valid manifests
  When I run check on valid manifests
  Then I must see no output