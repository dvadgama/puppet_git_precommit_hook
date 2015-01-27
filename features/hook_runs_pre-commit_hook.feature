Feature: pre-commit helper


 I need to run the pre-commit hook & need a helper class  which would in-turn 
 run check on the manifests (.pp) and, templates(.erb) for any syntax error
 
 
Scenario: Precommit helper run is not successful
  Given I have syntax error in my  files
  When I run the Precommit check with on invalid files
  Then I should see error displayed on screen
  And erroneous run must return :false
  
Scenario: Precommit helper run is successful
  Given I have error free files
  When I run the Precommit check on valid files
  Then I should not see any message on screen
  And clean run must return :true
   
Scenario: Precommit helper run has mixed response 
  Given I have valid manifest and invalid template 
  When I run the Precommit check on mixed files
  Then I should see template error on the screen 
  And mixed run must return :false

Scenario: Precommit helper run has no new files to process
  Given I have not added any new files
  When I run the Precommit check on empty file list
  Then I should not see anything on screen
  And empty run must return :nothingnew