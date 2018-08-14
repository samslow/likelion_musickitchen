class Music < ApplicationRecord
    after_commit :create_music_notification, on: :create 
    
    def create_music_notification
        Pusher.trigger('dashboard', 'create', self.as_json) #(channer_name, event_name, data)
    end
end
