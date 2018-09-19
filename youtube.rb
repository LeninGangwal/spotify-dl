
require 'json'
require 'yt'
require 'youtube-dl'

#To do: Try searching for lyrics video.

def send_request(title, artist)
  Yt.configure do |config|
    config.api_key = 'AIzaSyBEU6HVkxsZXySNUqZ77_PA5i5P4itzwZY'
  end
  videos = Yt::Collections::Videos.new
  response = videos.where(q: "#{title} #{artist}", order: "relevance", max_results: 5)
  response
end

def generate_list(title, artist)
  list = {}
  a = send_request(title, artist)
  puts a
  count = 0
  a.each do |video|
    count += 1
    list[video.id] = video.duration
    break if count == 5
  end
  list
end

def download(title, artist)
  video_id = generate_list(title, artist).first[0]
  url = "https://www.youtube.com/watch?v=" + video_id.to_s
  ##take the name from spotify
  YoutubeDL.download url, output: "#{title}.mp3"
end







