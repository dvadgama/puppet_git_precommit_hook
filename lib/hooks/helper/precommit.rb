module GitHooks
  module Helper
    class Precommit
      
      def initialize
	@git = GitHooks::Git::Info.new
        @run_validator = GitHooks::Checks::Puppet_syntax.new
	@run_style_validator = GitHooks::Checks::Puppet_style.new
	@run_status_flag = :true
      end
    
      def filter_files(files,filter)
        files.select{ | file | file.include?(filter) and !file.include?('hooks/') } 
      end
    
      def run
	
	files = @git.get_files
	manifest_files =  filter_files(files,'.pp')
	template_files =  filter_files(files,'.erb')
	
	#syntax check
	process_result(@run_validator.check_on(:manifest,manifest_files)) unless manifest_files == []
	process_result(@run_validator.check_on(:template,template_files)) unless template_files == []
	
	
	#style check
	process_result(@run_style_validator.check_on(manifest_files)) unless manifest_files == []
	
	
	@run_status_flag = :nothingnew if (manifest_files == [] and template_files == [] )

	@run_status_flag
      end

      def process_result(output)
	 @run_status_flag = :false unless output[:status]. max == 0
	 
	 if @run_status_flag == :false 
	   output[:status].each_with_index do | status,index |
  	     puts output[:msg][index] unless status == 0 
	   end
	 end
	
      end
      
    end    
  end
end
