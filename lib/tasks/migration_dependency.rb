require_relative 'migration'

require_relative '../core/io'

module Template
	class MigrationDependency < Migration

		def migrate
			@logger = PrettyLogger.logger("main")

			template_dash = Io.load_template_center_file(@center_dir, @template_name)
			template_use_dash = Io.load_template_use_file

			# dependency configure
			dependencis = template_dash['vocabulary']['dependency']
			if !dependencis.nil?
				dependency_plugin_dash = dependencis.select { |key, value| key != 'dependencies' }
				dependency_plugin = dependency_plugin_dash.keys[0]
				dependency_plugin_version = dependency_plugin_dash[dependency_plugin]
				
				dependency_ary = template_dash['vocabulary']['dependency']['dependencies']
				dependency_ary.each { |dependency| p "add dependency #{dependency} by #{dependency_plugin} #{dependency_plugin_version}." }
			end
		end

	end
end