require_relative '../core/io'

module Template
	class Center
		def initialize()

		end

		def init_as_center
			logger = PrettyLogger.logger("main")

			logger.add "Using local file-system as a template center."

			center_dir = File.dirname(__FILE__)
			center_dir = center_dir.gsub(/lib$/, '')
			# create .template-center
			center_file, global_center_file = Io.init_template_center(center_dir)

			logger.add "#{center_file} created.", 1
			logger.add "#{global_center_file} created.", 1
		end
	end
end