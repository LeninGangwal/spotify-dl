require 'rspotify'
require_relative 'youtube'

RSpotify.authenticate('09779337f34b4570a57dcc86d253e0c3', 'fe318e0d8d904978be0870c572139f10')


playlist = RSpotify::Playlist.find('leningangwal', '1HItlk8SR4naJBT9VkHctV')
count = 0
playlist.tracks.each do |track|
  count += 1
  artist = track.artists.first.name
  title = track.name
  download(title, artist)
  break if count == 5
end


