class Music < ApplicationRecord
    after_commit :create_music_notification, on: :create

    def create_music_notification
        Pusher.trigger('dashboard', 'create', self.as_json) #(channer_name, event_name, data)
    end

    def self.create_by_yt(url, status = 0)
      if url.include?("?v=")
        vid = url.split('?v=')[1]
        video = Yt::Video.new id: vid
        Music.create(title: video.title, vid: video.id, duration: video.duration, status: 0)
      else
        return false
      end
    end
end
