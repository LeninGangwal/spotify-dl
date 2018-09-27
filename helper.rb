require 'optparse'
require_relative 'spotify'
def get_params
  options = {}
  OptionParser.new do |opts|
    opts.banner = "Usage: example.rb [options]"
    opts.on('-s n', '--track = n', 'track') { |v| options[:track] = v }
    opts.on('-t n', '--title = n', 'title') { |v| options[:title] = v } #title=name of the song
    opts.on('-p n', '--playlist = n', 'playlist') { |v| options[:playlist] = v }
  end.parse!
  return options
end


def choose_function
  set_path
  params = get_params
  if params.has_key?(:track)
    download_track_using_http_url(params[:track])
  elsif params.has_key?(:title)
    download_track_using_name(params[:title])
  elsif params.has_key?(:playlist)
    download_playlist(params[:playlist])
  elsif params.has_key?(:help)
    help
    ##TODO: Add a help function which prints list of possible arguments
  else
    puts "Please try with --help"
  end
end

def help

end

def set_path
  Dir.chdir(File.join(Dir.home, "Documents"))
  Dir.mkdir("Downloaded Music") unless Dir.exists?("Downloaded Music")
  Dir.chdir(File.join(Dir.pwd,"Downloaded Music"))
  # print Dir.pwd
end

def set_path_playlist(playlist)
  Dir.mkdir(playlist) unless Dir.exists?(playlist)
  Dir.chdir(File.join(Dir.pwd, playlist))
end


def already_exists?(title)
  # puts Dir.glob("*")
  # puts title
  # puts Dir.pwd
  title = title.split("/").join(" ")
  return Dir.glob("*").include?(title + ".mp3")
end
choose_function



