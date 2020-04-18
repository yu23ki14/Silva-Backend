class UnderlyingIllness < ApplicationRecord
  has_many :client_illnesses
  has_many :clients, through: :client_illnesses
end
