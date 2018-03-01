module Template
	class Command
		def self.init(*params)
			raise ParamsError.new("Usage: templatecli init name version") until params.size == 2
			
			name 		= params[0]
			version = params[1]
			puts "execute init #{name}, #{version}"
		end

		def self.use
			puts "execute use"
		end

		def self.upgrade
			puts "execute upgrade"
		end
	end

	class ParamsError < StandardError
	end
end