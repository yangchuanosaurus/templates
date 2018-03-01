require 'yaml'

require_relative 'core/io'

module Template
	class Command
		def self.init(*params)
			raise ParamsError.new("Usage: templatecli init name version") until params.size == 2
			
			name 		= params[0]
			version = params[1]
			puts "execute init #{name}, #{version}"

			thing = YAML.load_file('./templates/templates.yml')
			thing['name'] = name
			thing['version'] = version
			file = Io.init_file(thing.to_yaml)

			"#{file} created."
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