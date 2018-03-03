require 'yaml'
require 'fileutils'

module Template
	class Io

		def self.init_template_file(content)
			template_file = "./template.prj"
			mode = "w"
			File.open(template_file, mode) do |file|
				file.puts content
			end

			template_file
		end

		def self.load_template_file
			template_file = "./template.prj"
			self.load_yaml(template_file)
		end

		def self.load_yaml(file)
			YAML.load_file(file)
		end

		def self.load_template_use_file
			template_use_file = './template_use.prj'
			self.load_yaml(template_use_file)
		end

		def self.init_template_use_file(name, version)
			template_use_file = './template_use.prj'
			use_content = {
				'use' => [
					name => version
				], 
				'vocabulary' => {
					'copy' => {
						'source' => 'main/src/java', 
						'resources' => 'main/src/resources'
					}
				}
			}
			mode = "w"
			File.open(template_use_file, mode) do |file|
				file.puts use_content.to_yaml
			end
		end

		def self.append_template_use_file(name, version)
			template_use_file = './template_use.prj'
			use_dash = YAML.load_file(template_use_file)
			use_template_ary = use_dash['use']

			use_template_ary.each { |use| use[name] = version if use.keys[0] == name }

			use_template_ary << {name => version}
			use_dash['use'] = use_template_ary.uniq
			mode = "w"
			File.open(template_use_file, mode) do |file|
				file.puts use_dash.to_yaml
			end
		end

		def self.create_directories(path)
			dirname = path
			tokens = dirname.split(/[\/\\]/)
			1.upto(tokens.size) do |n|
			  dir = tokens[0...n]
			  dir = dir.join("/")
			  Dir.mkdir(dir) unless Dir.exist?(dir)
			end
			tokens[0...tokens.size].join('/')
		end

		def self.copy_directories(src_path, dest_path)
			FileUtils.cp_r(src_path + '.', dest_path, :verbose => true)
		end

	end
end