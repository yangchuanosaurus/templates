require 'yaml'
require 'fileutils'

require_relative 'migration_dependency'
require_relative '../core/io'

module Template
	class MigrationDependencyGradle < MigrationDependency
		def migrate
		end
	end
end