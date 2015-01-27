module GitHooks
  module Checks
    class Puppet_syntax
    
      def initialize
	@shell = GitHooks::System::Command.new
      end
      
      def check_on(type,files)
	 result = { :status =>[] , :msg => [] }
	 if files.class.to_s == "NilClass"
	   return result
	 else
	  files.each do | file |
	    
	    case type
	    when :manifest
	      command = "puppet parser validate #{file}"
	    when :template
	      command = "erb -P -x -T '-' #{file}  | ruby -c"
	    end
	    output = @shell.execute(command)
	    result[:status].push(output[:status].first)
            result[:msg].push(output[:msg].join())
	  end
	 end
	 result
      end
            
    end
  end
end