require 'yaml'
require 'fileutils'

require_relative 'migration_dependency_gradle'
require_relative 'migration_copy'
require_relative '../core/io'

module Template
	class MigrationSchedule

		def initialize(center_dir, name, version)
			@center_dir 			= center_dir
			@template_name 		= name
			@template_version = version
		end

		def migrate
			logger = PrettyLogger.logger("main")

			template_dash = Io.load_template_center_file(@center_dir, @template_name)
			vocabulary = template_dash['vocabulary']

			vocabulary.map do |task, v|
				logger.add("Migrate with #{task} - #{v}", 1)
				
				v.map do |des, value|
					clazz_migration = "Migration#{task[0].upcase}#{task[1..-1]}#{des[0].upcase}#{des[1..-1]}"

					if !Template.const_defined?(clazz_migration)
						logger.add_error("#{task} of #{des} not defined.", @logger.level + 1)
					else
						logger.level = 1
						migration = Template.const_get(clazz_migration).new(@center_dir, @template_name)
						migration.migrate
					end
				end
				
				#t = Object.const_get(clazz_migration).const_set("center_dir", @center_dir).const_set("template_name", template_name)#.new(@center_dir, @template_name)
				#clazz = Object.const_get()
				#migration = 
			end
			# migration_copy = MigrationCopy.new(@center_dir, @template_name)
			# migration_copy.migrate
		end

	end
end