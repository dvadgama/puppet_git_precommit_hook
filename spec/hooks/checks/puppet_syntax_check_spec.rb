require 'spec_helper'

module GitHooks
  module Checks
    
    describe Puppet_syntax do
      let(:run_validator) { GitHooks::Checks::Puppet_syntax.new }
      let(:current_dir) { File.dirname(__FILE__) }
      
      describe "#check_on(:manifest,manifest_files)" do
	
	context "when supplied invalide manifest" do
	  it "must return an error message" do
	    files = ["#{current_dir}/invalid_node.pp"]
	    run_validator.check_on(:manifest,files)[:msg].each { | msg| expect(msg).to match(/Error/) }
	  end
	end
	
	context "when supplied with valid manifest" do
	  it "must return empty array" do
	    files = ["#{current_dir}/valid_node.pp"]
	    (run_validator.check_on(:manifest,files))[:msg].each { | msg| expect(msg).to eq("") }
	  end
	end
	
	context "when supplied with empty file set"  do
	  it "must return empty array" do
	    files = nil
	    (run_validator.check_on(:manifest,files))[:msg].each { |msg| expect(msg).to eq(nil) }
	  end
	end
	
      end
      
      describe "#check_on(:template,template_files)" do
	
	context "when supplied invalid template" do
	  it "must return  an error message" do
	    files = ["#{current_dir}/invalid_template.erb"]
	    run_validator.check_on(:template,files)[:msg].each { |msg| expect(msg).to include('syntax error') }
	  end
	end
	
	context "when supplied with a valid template" do
	  it "must return \"Syntax OK\" message" do
	    files = ["#{current_dir}/valid_template.erb"]
	    run_validator.check_on(:template,files)[:msg].each { |msg| expect(msg).to eq('Syntax OK') }
	  end
	end

	context "when supplied with empty file set" do
	  it "must return empty set" do
	    files = nil
	    (run_validator.check_on(:template,files))[:msg].each { |msg| expect(msg).to eq(nil) }
	  end
	end
	
      end     
      
    end
  end
end