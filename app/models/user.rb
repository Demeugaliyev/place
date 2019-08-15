class User < ActiveRecord::Base
  EMAIL_REG_EXP = { with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i, on: :create }
  has_many :reviews

  validates_presence_of :username, :email, :password
  validates_uniqueness_of :email
  validates :email, format: EMAIL_REG_EXP
end
