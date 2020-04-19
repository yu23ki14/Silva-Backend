# frozen_string_literal: true

class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  include DeviseTokenAuth::Concerns::User

  has_many :user_clients
  has_many :clients, through: :user_clients

  has_many :statuses
  has_many :actions

  has_many :invitations
  has_many :invites, class_name: "invitation", foreign_key: "from_user_id"
end
