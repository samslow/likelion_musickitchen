class Music < ApplicationRecord
    after_commit :create_music_notification, on: :create

    def create_music_notification
        # data code 추가 0 == music
        data = {code: 0, result: self.as_json}
        Pusher.trigger('dashboard', 'create', data) #(channer_name, event_name, data)
        Message.create(body: "#{self.title} \r\n 곡 신청 완료!")
    end

    def self.create_by_yt(url, status = 0)
      if url.include?("?v=")
        vid = url.split('?v=')[1]
        video = Yt::Video.new id: vid
        music = Music.create(title: video.title, vid: video.id, duration: video.duration, status: status)
        return music
      else
        return false
      end
    end
end
