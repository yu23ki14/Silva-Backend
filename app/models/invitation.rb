class Invitation < ApplicationRecord
  belongs_to :user, foreign_key: "user_id"
  belongs_to :client, foreign_key: "client_id"
  belongs_to :sended_user, class_name: "User", foreign_key: "from_user_id"

  enum role:{care_manager: 0, clinic: 1, nurse: 2, care: 3, rehabilitation: 4, medicine: 5, day_service: 6, dentistry: 7, other: 8}, _prefix: true

  validates :uid, uniqueness: true
end
