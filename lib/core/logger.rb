module PrettyLogger

	@loggers
	def PrettyLogger.logger(tag)
		@loggers = Hash.new if @loggers.nil?

		@loggers[tag] = Log.new(tag) if !@loggers.key?(tag)
		@loggers[tag]
	end

	class Log
		attr_reader :tag

		def initialize(tag)
			@tag = tag
			@msgs = Array.new
			@error_msgs = Array.new
		end

		def add(msg, level=0)
			@msgs << LogMsg.new(msg, level)
		end

		def add_error(msg)
			@error_msgs << LogMsg.new(msg, 1)
		end

		def log
			if !@error_msgs.empty?
				begin_msg = @msgs[0]
				puts begin_msg
				@error_msgs.each { |error| puts error.to_error }
			else
				@msgs.each { |msg| puts msg }
			end
			puts 'end.'

			@msgs.clear
			@error_msgs.clear
		end
	end

	private
	  class LogMsg
	  	attr_reader :msg, :level
	  	def initialize(msg, level)
	  		@msg = msg
	  		@level = level
	  	end

	  	def to_s
	  		spaces = ''
	  		(@level * 2).times { |i| spaces += ' ' }
	  		"#{spaces}#{@msg}"
	  	end

	  	def to_error
	  		spaces = ''
	  		(@level * 2).times { |i| spaces += ' ' }
	  		"#{spaces}[ERROR] #{@msg}"
	  	end
	  end

end

# logger = PrettyLogger.logger("A")
# logger.add("Command: Init as a template project")
# logger.add("./template.prj created.", 1)
# logger.add("./files created.", 1)
# logger.log

# logger.add("Command: Init as a template project")
# logger.add_error("failed no arg of name.")
# logger.add_error("failed no arg of version.")
# logger.log

# logger.add("Command: Init as a template project")
# logger.add("Folder ./actions created.", 1)
# logger.add("./actions/file1 created. (* define something here)", 2)
# logger.add("./actions/file2 created. (* define something here)", 2)
# logger.add("./files created.", 1)
# logger.log
