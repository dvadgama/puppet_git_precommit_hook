require 'open4'

module GitHooks
  module System
    class Command
      
      def initialize
	@status,@output = ''
      end
      
      def execute(*command)
	
	begin
	  #in case i switch to open4
	  pid,stdin,stdout,stderr = Open4.popen4(*command)
	  ignore,status = Process::waitpid2 pid
	  @status = status.exitstatus.to_i
	  
	  out = format_output(stdout)
	  err = format_output(stderr)
	  @output = out | err
	
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