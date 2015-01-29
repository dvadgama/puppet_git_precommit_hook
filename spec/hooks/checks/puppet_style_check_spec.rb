require 'spec_helper'

module GitHooks
  module Checks
    
    describe Puppet_style do
      
      describe "#check_on(files)" do
	
	let (:run_syntax) { GitHooks::Checks::Puppet_style.new }
	
	before(:all) do
	  @curr_dir = File.dirname(__FILE__)
	end
	
	context "file do not have any syntax error" do
	  it "must return nil" do
	    file = ["#{@curr_dir}/well_formated_manifest.pp"]
	    expect(run_syntax.check_on(file)).to eq({:status =>[0],:msg => [""]})
	  end
	end
	
	context "file  have unfixable syntax error" do
	  it "must return error" do
	    file = ["#{@curr_dir}/badly_formated_manifest.pp"]
	    expect(run_syntax.check_on(file)[:status]).to eq([1])
	  end
	end

	
      end
        
    end
    
  end
end