require 'taglib'
# require ''
Dir.chdir("/Users/lenin.gangwal/Documents/Downloaded Music")
puts Dir.glob("*")
TagLib::MPEG::File.open("Première Gymnopédie.mp3") do |mp3_file|
	t = mp3_file.id3v2_tag
	puts t.artist
	puts t.album
	mp3_file.save
end
