require 'spec_helper'

module GitHooks
  module Git
    
    describe Info do
      
      let(:repository) { GitHooks::Git::Info.new }
      
      describe "#get_root" do
	context "when asked for git_root" do
	  it "it must give the root directory for the respository" do
	    expect(File).to exist(repository.get_root) 
	  end
	end
      end
      
      describe "#get_head" do
	context "When asked for the HEAD of current branch" do
	  it "must return the valid 40 char long sha" do
	    expect(repository.get_head()[:msg]).to match([/(\w|\d){40}/])
	  end
	end
      end
      
      describe "#get_empty_head" do
	context "when asked for the HEAD of current branch, in empty git tree" do
	  it "must return the famous empty tree haash i.e. \"4b825dc642cb6eb9a060e54bf8d69288fbee4904\"" do
	    expect(repository.get_empty_head()[:msg]).to eq(["4b825dc642cb6eb9a060e54bf8d69288fbee4904"])
	  end
	end
      end
      
      describe "#get_files" do
	context "when asked to get git diff-index"  do
	  it " must get all newly added,copied or modified file in repository" do
	    repository.get_files().each { | file |expect(File).to exist(file) }
	  end
	end
      end
      
    end
  end
end