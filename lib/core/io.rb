module Template
	class Io
		def self.init_template_file(content)
			template_file = "./template_define.yml"
			mode = "w"
			File.open(template_file, mode) do |file|
				file.puts content
			end

			template_file
		end
	end
end