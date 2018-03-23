require 'yaml'
require 'fileutils'

require_relative 'migration_dependency'
require_relative '../core/io'

module Template
	class MigrationDependencyGradle < MigrationDependency

		def migrate
			@logger = PrettyLogger.logger("main")

			template_dash = Io.load_template_center_file(@center_dir, @template_name)
			template_use_dash = Io.load_template_use_file
			dependencis = template_dash['vocabulary']['dependency']

			if !dependencis.nil?
				gradle_dependencies = dependencis['gradle']
				if !gradle_dependencies.nil?

					gradle_dependencies.each do |gradle|
						@logger.add("Gradle migrating implementation '#{gradle}' into :app/build.gradle", @logger.level + 1)
					end
					
				end
			end
		end
	end
end