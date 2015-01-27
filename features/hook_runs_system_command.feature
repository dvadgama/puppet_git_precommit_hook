Feature: execute shell command

As a hook developer, I need to execute few system/shell commands for following
1) execute git commands to get information like
   git tree root
   git rev-parse
   git empty hash

2) execute the puppet parser
3) execute puppet lint 
4) execure rspec on module..
5) any thing else..

Scenario Outline:
  Given <system> supports the <command>
  When  I pass on  a system command <command>
  Then I should see a <result> with <status>

  Examples: System is linux, with successful commands
 
  | os     | command      | result | status |
  | linux  |  uname       | Linux  |   0    |
  | linux  |  echo Hello  | Hello  |   0    | 

 
  Examples: System is linux, with wrong or error pron commands
 
  | os     | command     | result            | status |
  | linux  | abcdefg     | command not found |  127   |
  | linux  | hijklm nop  | command not found |  127   | 