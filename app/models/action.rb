class Action < ApplicationRecord
  belongs_to :client, foreign_key: "client_id"
  belongs_to :user, foreign_key: "user_id"

  enum role:{care_manager: 0, clinic: 1, nurse: 2, care: 3, rehabilitation: 4, medicine: 5, day_service: 6, dentistry: 7, other: 8}
end
