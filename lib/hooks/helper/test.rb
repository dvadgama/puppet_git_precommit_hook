module GitHooks
  module Helper
    
    class Test
      
      def initialize
	@dest = []
	@shell = GitHooks::System::Command.new
      end
      
      #create git branch for rspec test
      def create_git_branch
	@shell.execute("git checkout -b rspec_test_branch")
      end
      
      # copy file to the test directory
      def copy_file(src,dest)
	dest = dest.lines unless dest.class.to_s == "Array"
	src = src.lines unless src.class.to_s == "Array"
	@dest = dest
		
	@dest.each_with_index do | destination, index |
	  directory = File.dirname(destination)
	  @shell.execute("mkdir -p #{directory}") unless File.directory?(directory)
	  @shell.execute("cp #{src[index]} #{destination}")
	end
      end
      
      #add file to git test branch 
      def add_to_git
	@dest.each { | destination | @shell.execute("git add #{destination}") }
      end
      
      # unstage and delete the file
      def delete_file
	@dest.each { | destination | @shell.execute("git reset HEAD #{destination}") ; @shell.execute("rm -f #{destination}") }
      end
      
      #clean it up   
      def delete_git_branch
	
	@shell.execute("git checkout master")
	directories = @dest.inject([]) { |dir,file| dir << File.dirname(file) ; dir }.uniq
	directories.each { | dir | @shell.execute("rm -rf #{dir}") }
	@shell.execute("git branch -d rspec_test_branch")
	
      end

    end
  end
end
