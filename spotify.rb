require 'rspotify'
require_relative 'youtube'
# require_relative 'helper'
RSpotify.authenticate('09779337f34b4570a57dcc86d253e0c3', 'fe318e0d8d904978be0870c572139f10')

## TODO: Add metadata
## TODO: Catch exceptions
## TODO: Set download destination
## TODO: Learn how to create a gem
## TODO: Check validity of url

def download_track_using_http_url(url)
  track = RSpotify::Track.find(get_track_id(url))
  title = track.name
  artist = track.artists.first.name
  download(title, artist)
end

def download_track_using_name(track_name)
  download(track_name, "")
end

def download_playlist(url)
  playlist = RSpotify::Playlist.find(get_user_name(url), get_playlist_id(url))
  count = 0
  playlist.tracks.each do |track|
    count += 1
    artist = track.artists.first.name
    title = track.name
    download(title, artist)
    break if count == 5
  end
end


def get_metadata

end

def isValidUrl?(url)

end

def get_user_name(url)
  puts url
  url.split("/")[4]
end

def get_playlist_id(url)
  url.split("/")[6].split("?")[0]
end

def get_track_id(url)
  url.split("/")[4].split("?")[0]
end

# download_playlist(get_params()[:playlist])


