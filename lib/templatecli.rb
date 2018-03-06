require 'yaml'

require_relative 'core/io'

module Template

	class Command

		def self.init(*params)
			logger = PrettyLogger.logger("main")
			logger.add("templatecli init template_name version")
			if params.empty? || params.size < 2
				logger.add_error("wrong arguments of `init`.")
				return
			end
			
			name 		= params[0]
			version = params[1]
			if name.downcase == 'as'
				if version == 'center'
					init_as_center
					return
				else
					logger.add_error("arguments of `init` should be `as center`.")
					return
				end
			end

			# create templates.yml, which is used for define the name, and version (major-version, sub-version, minor-version)
			template_definition = Hash.new
			template_definition['template-center'] = 'http://center.code-template.org'
			template_definition['name'] = name
			template_definition['version-string'] = version
			template_definition['version'] = version.split('.').map { |v| v.to_i }
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

		def self.init_as_center
			puts "Using local file-system as a template center."

			center_dir = File.dirname(__FILE__)
			center_dir = center_dir.gsub(/lib$/, '')
			# create .template-center
			center_file = Io.init_template_center(center_dir)

			puts "#{center_file} of #{center_dir} created."
			# let templatecli knows where's the local template-center

		end

		def self.use(*params)
			raise ParamsError.new("Usage: templatecli use name version[optional]") until params.size == 1 || params.size == 2

			name 		= params[0]
			version = params.size == 2 ? params[1] : 'latest'

			# check if template_use.prj defined
			template_use_file = 'template_use.prj'
			template_use_dash = nil
			if !File.exist?(template_use_file)
				template_use_dash = Io.init_template_use_file(name, version)
			else
				template_use_dash = Io.append_template_use_file(name, version)

			end

			puts "execute use #{name} #{version}"

			# Download templates
			# Get the template information from center
			# Download templates from git to ./.templates
			# Start copy progress

			# Skip download templates
			template_dash = Io.load_template_file
			template_use_dash = Io.load_template_use_file

			# copy source to destination
			source_ary = template_dash['vocabulary']['copy']['source']
			desination_src = template_use_dash['vocabulary']['copy']['source']
			Io.create_directories(desination_src)

			source_ary.each { |src| Io.copy_directories(src, desination_src) }
			# copy resource to destination
			desination_res = template_use_dash['vocabulary']['copy']['resources']
			resource_ary = template_dash['vocabulary']['copy']['resources']
			Io.create_directories(desination_res)

			resource_ary.each { |res| Io.copy_directories(res, desination_res) }

			# dependency configure
			dependency_plugin_dash = template_dash['vocabulary']['dependency'].select { |key, value| key != 'dependencies' }
			dependency_plugin = dependency_plugin_dash.keys[0]
			dependency_plugin_version = dependency_plugin_dash[dependency_plugin]
			
			dependency_ary = template_dash['vocabulary']['dependency']['dependencies']
			dependency_ary.each { |dependency| p "add dependency #{dependency} by #{dependency_plugin} #{dependency_plugin_version}." }

			"#{template_use_file} created."
		end

		def self.publish
			puts "execute publish"
			# Publish current template project to center
			# Tell the center name, version, git address
		end

		def self.check
			if dash = Io.load_template_center?
				puts "Template center:"
				dash.each do |key, value|
					puts "\t#{key} = #{value}"
				end
				"=====Local template center exists."
			else
				"No template center initialize in local file-system."
			end
		end

	end

	class ParamsError < StandardError
	end
end