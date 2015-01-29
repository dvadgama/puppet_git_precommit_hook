Feature: puppet style check

I need to share the module with community/company users and, it needs to be well formated module
to be able to complines with puppet styling guide. Hence, I need to run puppet lint on file to fix 
and/or highlight any stlying error(s)

Scenario: I have ill formated manifest
  Given I have an ill formated manifest 
  When  I run puppet style check on ill manifest
  Then  ill formated check message should say FIXED:
  And   status should change to 0

Scenario: I have a badly formated manifest
  Given I have a badly formated manifest
  When  I run puppet style check on bad manifest
  Then  I should see error in response
  And   Error status should be 1
  
Scenario: I have well formated manifest
  Given I have a well formated manifest
  When  I run puppet style check on well manifest
  Then  I should not see any response
  And   Success status should be 0