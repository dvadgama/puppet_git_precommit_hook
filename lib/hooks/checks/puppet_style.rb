module GitHooks
  module Checks
    class Puppet_style
    
      def initialize
	@shell = GitHooks::System::Command.new
      end
      
      def check_on(files)
	 result = { :status =>[] , :msg => [] }
	 if files.class.to_s == "NilClass"
	   return result
	 else
	    files.each do | file |
	      output = @shell.execute("puppet-lint -f #{file}")
	      output[:status] = [0] if output[:msg].first != nil and (output[:msg].first).match(/^FIXED:/) 
	      result[:status].push(output[:status].first)
              result[:msg].push(output[:msg].join())
	    end
	   end
	 result
      end
      
    end
  end
end