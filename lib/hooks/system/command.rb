require 'open3'

module GitHooks
  module System
    class Command
      
      def initialize
	@shell = Open3
	@status,@output = ''
      end
      
      def execute(command)
	
	begin
	  @shell.popen3(command) do | stdin,stdout,stderr,wait_thread |
	    @status = wait_thread.value.to_i
	    @output = @status==0 ? format_output(stdout) : format_output(stderr)
	  end
	
	rescue Errno::ENOENT
	  return {:status => [127], :msg => ["command not found"]}
	  
	else
	  return { :status => [@status],:msg => @output }
	end
      end
      
      def format_output(output)
	lines = []
	while line = output.gets
	  lines.push(line.strip)
	end
	lines
      end
      
    end
  end
end