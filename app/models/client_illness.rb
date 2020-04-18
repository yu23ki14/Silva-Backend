class ClientIllness < ApplicationRecord
  belongs_to :underlying_illness, foreign_key: "underlying_illness_id"
  belongs_to :client, foreign_key: "client_id"
end
