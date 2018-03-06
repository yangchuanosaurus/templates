module Template
	class Project
		def initialize(name, version)
			@name = name
			@version = version
		end

		def init
			logger = PrettyLogger.logger("main")
			
			template_definition = Hash.new
			template_definition['template-center'] = 'http://center.code-template.org'
			template_definition['name'] = @name
			template_definition['version-string'] = @version
			template_definition['version'] = @version.split('.').map { |v| v.to_i }
			dependency_system = 
			template_definition['vocabulary'] = {
				'copy' => {
					'source' => ["folder1", "folder2"], 
					"resources" => ["folder1", "folder2"]
				}, 
				'dependency' => {
					'gradle' => '3.0.1', 
					'dependencies' => ['a', 'b']
				}
			}
			template_definition['templates'] = {'SampleTemplate' => '1.0.0', "OtherTemplate" => 'latest'}
			templates_file = Io.init_template_file(template_definition.to_yaml)

			logger.add("#{templates_file} created.", 1)
		end
	end
end