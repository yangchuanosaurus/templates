require 'yaml'
require 'fileutils'

require_relative 'migration'
require_relative '../core/io'

module Template
	class MigrationCopy < Migration
		def migrate
			# @logger = PrettyLogger.logger("main")
			# template_dash = Io.load_template_center_file(@center_dir, @template_name)
			# template_use_dash = Io.load_template_use_file

			# # copy source to destination
			# source_ary = template_dash['vocabulary']['copy']['source']
			# desination_src = template_use_dash['vocabulary']['copy']['source']
			# Io.create_directories(desination_src)

			# source_ary.each { |src| copy_directories("#{@center_dir}/#{@template_name}/#{src}/.", desination_src) }
			# # copy resource to destination
			# desination_res = template_use_dash['vocabulary']['copy']['resources']
			# resource_ary = template_dash['vocabulary']['copy']['resources']
			# Io.create_directories(desination_res)

			# resource_ary.each { |res| copy_directories(res, desination_res) } if !resource_ary.nil?
		end

		def copy_directories(src_path, dest_path)
			@logger.add("copy #{src_path}. to #{dest_path}", @logger.level + 1)
			FileUtils.cp_r(src_path, dest_path, :verbose => true)
		end

	end

	class MigrationCopySource < MigrationCopy
		
		def migrate
			@logger = PrettyLogger.logger("main")
			template_dash = Io.load_template_center_file(@center_dir, @template_name)
			template_use_dash = Io.load_template_use_file

			# copy source to destination
			source_ary = template_dash['vocabulary']['copy']['source']
			desination_src = template_use_dash['vocabulary']['copy']['source']
			Io.create_directories(desination_src)

			source_ary.each { |src| copy_directories("#{@center_dir}/#{@template_name}/#{src}/.", desination_src) }
		end

	end

	class MigrationCopyResource < MigrationCopy
		def migrate
			@logger = PrettyLogger.logger("main")
			template_dash = Io.load_template_center_file(@center_dir, @template_name)
			template_use_dash = Io.load_template_use_file

			desination_res = template_use_dash['vocabulary']['copy']['resources']
			resource_ary = template_dash['vocabulary']['copy']['resources']
			Io.create_directories(desination_res)

			resource_ary.each { |res| copy_directories(res, desination_res) } if !resource_ary.nil?
		end
	end
end