require 'yaml'

require_relative 'core/io'

module Template
	class Command

		def self.init(*params)
			raise ParamsError.new("Usage: templatecli init name version") until params.size == 2
			
			name 		= params[0]
			version = params[1]
			puts "execute init #{name}, #{version}"

			# create templates.yml, which is used for define the name, and version (major-version, sub-version, minor-version)
			template_definition = Hash.new
			template_definition['template-center'] = 'http://center.code-template.org'
			template_definition['name'] = name
			template_definition['version-string'] = version
			template_definition['version'] = version.split('.').map { |v| v.to_i }
			dependency_system = 
			template_definition['vocabulary'] = {
				'copy' => ["folder1", "folder2"], 
				'dependency' => {
					'gradle' => '3.0.1', 
					'dependencies' => ['a', 'b']
				}
			}
			template_definition['templates'] = {'SampleTemplate' => '1.0.0', "OtherTemplate" => 'latest'}
			templates_file = Io.init_template_file(template_definition.to_yaml)

			"#{templates_file} created."
		end

		def self.use
			puts "execute use"
		end

		def self.upgrade
			puts "execute upgrade"
		end

		def self.publish
			puts "execute publish"
		end
		
	end

	class ParamsError < StandardError
	end
end