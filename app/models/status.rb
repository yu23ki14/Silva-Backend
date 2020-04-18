class Status < ApplicationRecord
  belongs_to :client, foreign_key: "client_id"
  belongs_to :user, foreign_key: "user_id"
end
