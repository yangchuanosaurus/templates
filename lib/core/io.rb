module Template
	class Io
		def self.init_file(content)
			file = "./template_define.yml"
			mode = "w"
			File.open(file, mode) do |file|
				file.puts content
			end

			file
		end
	end
end