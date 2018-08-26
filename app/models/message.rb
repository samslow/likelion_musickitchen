class Message < ApplicationRecord
  acts_as_paranoid
  after_commit :create_message_notification, on: :create

  def create_message_notification
      # data code 추가 0 == music
      unless self.body == ""
        data = {code: 1, result: self.as_json}
        Pusher.trigger('dashboard', 'create', data) #(channer_name, event_name, data)
      end
  end

  def self.delete_message
    Message.where(body: nil).delete_all
    Message.where(body: "").delete_all
    Message.where("body LIKE ?","%신청 완료!").delete_all
  end
end
