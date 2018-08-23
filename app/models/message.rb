class Message < ApplicationRecord
  after_commit :create_message_notification, on: :create

  def create_message_notification
      # data code 추가 0 == music
      unless self.body == ""
        data = {code: 1, result: self.as_json}
        Pusher.trigger('dashboard', 'create', data) #(channer_name, event_name, data)
      end
  end
end
