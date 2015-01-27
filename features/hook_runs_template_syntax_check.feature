Feature: hook runs the syntax check on erb template

 I have the list of git files which are either added,copied or modified 
 and, now i want to run it through erb check  to ensure there are no syntax errors
 
Scenario: We have an invalid template
  Given I have an invalid template
  When I run check on invalid template
  Then I must see error message syntax error
  
Scenario: We have a valid template 
  Given I have a valid template
  When I run check on valid template 
  Then I must see success message Syntax OK