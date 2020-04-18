class Client < ApplicationRecord
  has_many :user_clients
  has_many :users, through: :user_clients

  has_many :client_illnesses
  has_many :underlying_illnesses, through: :client_illnesses

  has_many :statuses
  has_many :actions

  enum grade: {P: 0, G3: 1, G2: 2, G1: 3, N2: 4, N1: 5}
  enum gender: {F: 0, M: 1}
end
