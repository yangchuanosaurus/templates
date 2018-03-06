require 'yaml'

require_relative 'core/io'
require_relative 'template/project'
require_relative 'template/center'

module Template

	class Command

		def self.init(*params)
			logger = PrettyLogger.logger("main")
			
			if params.empty? || params.size < 2
				logger.add("templatecli init template_name version")
				logger.add_error("wrong arguments of `init`.")
				return
			end
			
			name 		= params[0]
			version = params[1]
			if name.downcase == 'as'
				if version == 'center'
					center = Center.new
					center.init_as_center
					return
				else
					logger.add_error("arguments of `init` should be `as center`.")
					return
				end
			end

			# create templates.yml, which is used for define the name, and version (major-version, sub-version, minor-version)
			logger.add("templatecli init template_name version")
			project = Project.new(name, version)
			project.init
			
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

		def self.info
			logger = PrettyLogger.logger("main")

			if dash = Io.load_template_center?
				logger.add("Template center:")
				dash.each do |key, value|
					logger.add("#{key} = #{value}", 1)
				end
			else
				logger.add_error("No template center initialize in local file-system.")
			end
		end

	end

	class ParamsError < StandardError
	end
end