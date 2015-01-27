module GitHooks
  module Git
    class Info
      
      def initialize
	@shell = GitHooks::System::Command.new
	@head = ''
	get_head()
      end
      
      def get_root
	@shell.execute('git rev-parse --show-toplevel')[:msg].first
      end
      
      def get_head()
	@head = @shell.execute('git rev-parse --quiet --verify HEAD')
	@head[:msg] == '' ? get_empty_head() : @head
      end
      
      def get_empty_head()
	@head = @shell.execute('git hash-object -t tree /dev/null')
	@head
      end
      
      def get_files()
	output = @shell.execute("git diff-index --diff-filter=ACM  --name-only --cached #{@head[:msg].first}")
	git_root = get_root()
	output[:msg].map! { | file | "#{git_root}/#{file}"}
      end
      
      def exist?(directory)
	File.directory?(directory)
      end
  
    end
  end
end