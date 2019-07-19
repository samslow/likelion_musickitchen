class Music < ApplicationRecord
    after_commit :create_music_notification, on: :create

    def create_music_notification
        # data code 추가 0 == music
        data = {code: 0, result: self.as_json}
        Pusher.trigger('mychannel', 'create', data) #(channer_name, event_name, data)
        Message.create(body: "#{self.title} \r\n 곡 신청 완료!", applicant: self.applicant, state: 1)
    end

    def self.create_by_yt(url, status = 0)
      if url.include?("?v=")
        videoId = url.split('?v=')[1] # mw5VIEIvuMI
        videoReq = "https://www.googleapis.com/youtube/v3/videos?id=#{videoId}&key=#{ENV["GOOGLE_YOUTUBE_KEY"]}&part=snippet,contentDetails"
        video = RestClient.get(videoReq)
        parsed = JSON.parse(video)
        music = Music.create(
          title: parsed['items'][0]['snippet']['title'],
          vid: parsed['items']['id'],
          duration: parsed['items']['contentDetails']['duration'], status: status)
        # 임시
        return music
      else
        return false
      end
    end
end
