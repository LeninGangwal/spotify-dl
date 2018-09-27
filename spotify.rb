require 'rspotify'
require_relative 'youtube'
require_relative 'helper'
require 'taglib'
RSpotify.authenticate('09779337f34b4570a57dcc86d253e0c3', 'fe318e0d8d904978be0870c572139f10')

## TODO: Add metadata
## TODO: Catch exceptions
## TODO: Learn how to create a gem
## TODO: Check validity of url
## TODO: Check for partial downloads using metadata


def download_track_using_http_url(url)
  track = RSpotify::Track.find(get_track_id(url))
  title = track.name
  artist = track.artists.first.name
  download(title, artist) unless already_exists?(title)
  set_metadata(track, title)
end

def download_track_using_name(track_name)
  download(track_name, "") unless already_exists?(track_name)
end

def download_playlist(url)
  playlist = RSpotify::Playlist.find(get_user_name(url), get_playlist_id(url))
  set_path_playlist(playlist.name)
  puts "Downloading playlist => #{playlist.name}"
  count = 0
  playlist.tracks.each do |track|
    count += 1
    artist = track.artists.first.name
    title = track.name.split.map(&:capitalize).join(" ")
    if not title.empty? and not already_exists?(title)
      download(title, artist)
      set_metadata(track, title) unless title.empty?
    end
    break if count == 5
  end
end


def set_metadata(track, title)
  # puts "Setting metadata"
  title = title.split("/").join(" ")
  TagLib::MPEG::File.open(title + ".mp3") do |mp3_file|
    tags = mp3_file.id3v2_tag
    tags.album = track.album.name
    tags.artist = track.artists.first.name
    apic = TagLib::ID3v2::AttachedPictureFrame.new
    apic.mime_type = "image/jpeg"
    apic.description = "Cover"
    apic.type = TagLib::ID3v2::AttachedPictureFrame::FrontCover
    spotify_pic_url = track.album.images.first["url"] ? track.album.images.first["url"] : false
    if spotify_pic_url
      apic = TagLib::ID3v2::AttachedPictureFrame.new
      apic.mime_type = "image/jpeg"
      apic.description = "Cover"
      apic.type = TagLib::ID3v2::AttachedPictureFrame::FrontCover
      apic.picture = open(spotify_pic_url).read
    end
    mp3_file.save
  end
end


def isValidUrl?(url)

end

def get_user_name(url)
  url.split("/")[4]
end

def get_playlist_id(url)
  url.split("/")[6].split("?")[0]
end

def get_track_id(url)
  url.split("/")[4].split("?")[0]
end



