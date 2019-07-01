require 'httparty'
response = HTTParty.get('https://www.googleapis.com/youtube/v3/videos?id=WZq3WtbpB80&key=AIzaSyDQPB4uLv0JRsc96jVHaCBv3ykhAWAFb4w&part=snippet')
p response