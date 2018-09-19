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
  params = get_params
  puts params
  if params.has_key?(:track)
    download_track_using_http_url(params[:track])
  elsif params.has_key?(:title)
    download_track_using_name(params[:title])
  else
    download_playlist(params[:playlist])
  end
end

choose_function

