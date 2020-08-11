class Attendance < ApplicationRecord
  belongs_to :user
  belongs_to :event

  after_create :attendance_send

  def attendance_send
    UserMailer.attendance_email(User.find(self.user_id), Event.find(self.event_id)).deliver_now
  end
end
