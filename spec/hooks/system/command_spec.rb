require 'spec_helper'

module GitHooks
  module System
    describe Command  do
      
      let (:shell) { GitHooks::System::Command.new }
         
      describe "#execute" do
	context "with successful" do
	  
	  it "echo command, It must get Hello as a output & 0 as a exit status" do
	     expect(shell.execute('echo Hello')).to eq({:status=> [0],:msg=> ["Hello"]})
	  end
	  
	  it "uname command, It must get Linux as a output & 0 as a exit result" do
	    expect(shell.execute('uname')).to eq({:status =>[0],:msg => ["Linux"] })
	  end


	end
	
	context "with wrong command" do
	  it " abcdefg , it must get error: command not found and 127 as a exit status " do
	    expect(shell.execute('abcdefg')).to eq({:status => [127],:msg => ["command not found"]})
	  end
	end
	
      end
      
    end
  end
end