require 'yaml'

require_relative 'core/io'
require_relative 'template/project'
require_relative 'template/center'
require_relative 'tasks/migration_schedule'
require_relative 'core/logger'

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
				if version.downcase == 'center'
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
			logger = PrettyLogger.logger("main")

			if params.empty?
				logger.add("templatecli use template_name version[optional]")
				logger.add_error("wrong arguments of `use`.")
				return
			end

			name 		= params[0]
			version = params.size == 2 ? params[1] : 'latest'

			logger.add("templatecli use #{name} #{version}")

			# check if template_use.prj defined
			template_use_file = 'template_use.yml'
			if !File.exist?(template_use_file)
				logger.add("#{template_use_file} created.", 1)
			else
				logger.add("#{template_use_file} updated.", 1)
			end
		end

		def self.install
			logger = PrettyLogger.logger("main")
			logger.add("templatecli install")

			# check if template_use.prj defined
			template_use_file = 'template_use.yml'
			template_use_dash = nil
			if !File.exist?(template_use_file)
				logger.add_error("#{template_use_file} doesn't exits.", 1)
				return
			else
				template_use_dash = Io.load_template_use_file
				logger.add("Scan #{template_use_file}", 1)
			end
			
			center_dash = Io.load_template_center?
			center_dir = center_dash[:local]

			template_use_dash["use"].each do |template|
				template.each do |template_name, version|
					logger.add("Install Template: #{template_name} - #{version}", 2)
					logger.level = 2
					migration = MigrationSchedule.new(center_dir, template_name, version)
					migration.migrate

				end
			end
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