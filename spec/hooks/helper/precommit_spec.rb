require 'spec_helper'

module GitHooks
  module Helper
    
    describe Precommit do
    
      let(:precommit) { GitHooks::Helper::Precommit.new }
    
      describe "#filter_files" do
      
	context "when processing files for manifests" do
	  it "must return files with .pp extntion only" do
	    precommit.filter_files(["myfav.erb","non_existing.pp"],'.pp').each { | file | expect(file).to end_with('.pp') } 
	  end
        end
      
	context "when processing files for templates" do
	  it "must return files with .erb extention only" do
	    precommit.filter_files(["non_existing.erb","myfav.pp"],'.erb').each { | file | expect(file).to end_with('.erb') }
	  end
        end
      
        
	context "when files are from with-in hooks driectory" do
	  it "must get filtered out,since they are test only files" do
	    precommit.filter_files(["funny_test/hooks/whatever.pp"],'.pp').each { | file | expect(file).to !include('hooks/') }
	  end
        end
      
	context "when no files are supplied" do
	  it "must  return an empty array" do
	    precommit.filter_files([],'.pp').each { | file | expect(file).to eq([]) }
	  end
	end
	
      end
      
      
      describe "#process_result(output)" do
	
	context "when out put contains both error and suceess" do
	  it "must display only errors and, no sucess result"  do
	    output = {:status=>[0, 0,127, 0], :msg=>["all okie", "yea..still fine", "kaboom", "back to okie"]}
	    expect(STDOUT).to receive(:puts).with("kaboom")
	    precommit.process_result(output)
	  end
	end
	
	context "when we have only sucess message" do
	  it "must not display anything"   do
	    output = {:status=>[0, 0,0, 0], :msg=>["all okie", "yea..still fine", "kaboom", "back to okie"]}
	    expect(STDOUT).to_not receive(:puts).with("kaboom")
	    precommit.process_result(output)
	  end
	end
	
      end
      
      
      describe "#run" do
	
	before(:all) do
	  $stdout = StringIO.new
	  @spechelper = GitHooks::Helper::Test.new
	  @spechelper.create_git_branch
	  git = GitHooks::Git::Info.new
	  @dest_dir = "#{git.get_root()}/rspec_test"
	  @curr_dir = File.dirname(__FILE__)
	end
	
	context "when files are valid" do
	  
	  it "must return true for a valide manifest file" do
	    src,dest  = "#{@curr_dir}/valid_node.pp", "#{@dest_dir}/valid_node.pp"
	    @spechelper.copy_file(src,dest)
	    @spechelper.add_to_git
	    expect(precommit.run).to eq(:true)
	  end
	  
	  it "must return true for a valide template file" do
	    src,dest  = "#{@curr_dir}/valid_template.erb", "#{@dest_dir}/valid_template.erb"
	    @spechelper.copy_file(src,dest)
	    @spechelper.add_to_git
	    expect(precommit.run).to eq(:true)
	  end
	  
	end
	
	context "when files are invalid" do
	  
	  it "must return false & display error for an invalide manifest file" do
	    src,dest  = "#{@curr_dir}/invalid_node.pp", "#{@dest_dir}/invalid_node.pp"
	    @spechelper.copy_file(src,dest)
	    @spechelper.add_to_git
	    expect(precommit.run).to eq(:false)
	    expect($stdout.string).to match(/error/)
	  end
	  
	  it "must return false & display error message for an invalide template file" do
	    src,dest  = "#{@curr_dir}/invalid_template.erb", "#{@dest_dir}/invalid_template.erb"
	    @spechelper.copy_file(src,dest)
	    @spechelper.add_to_git
	    expect(precommit.run).to eq(:false)
	    expect($stdout.string).to match(/error/)
	  end
	
	end
	
	
	context "When there are no new files" do
	  
	  it "must return :nothingnew" do
	    expect(precommit.run).to eq(:nothingnew)
	  end
	  
	end
	
	context "When newly added files are not manifest or template files" do
	  
	  it "must return :nothingnew" do
	    src,dest = "#{@curr_dir}/#{File.basename(__FILE__)}", "#{@dest_dir}/#{File.basename(__FILE__)}"
	    @spechelper.copy_file(src,dest)
	    @spechelper.add_to_git
	    expect(precommit.run).to eq(:nothingnew)
	  end
	  
	end
	
	after(:each) do
	  @spechelper.delete_file
	end
	
	after(:all) do
	  @spechelper.delete_git_branch
	  $stdout = STDOUT
	end
	
      end
      
    end
  end
end