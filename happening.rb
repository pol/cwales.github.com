#!/usr/bin/env ruby


printed_files = []

File.open("printed_index", "r").each_line do |line|
	printed_files << line
end

printed_files = printed_files.map{|f| f.strip }.select{|f| f.size > 0 }.uniq

files = []

File.open("SPOOL/index.html", "r").each_line do |line|
  	files << line.strip
end

new_files = []

files.reverse.each do |file|
	unless printed_files.include?(file)
		puts "lp -o raw -d Hewlett_Packard_HP_LaserJet_1200 SPOOL/#{file}"
		`lp -o raw -d Hewlett_Packard_HP_LaserJet_1200 SPOOL/#{file}`
		new_files << file.strip
	end
end

File.open("printed_index", 'a+') { |file| file.write(new_files.join("\n")) }