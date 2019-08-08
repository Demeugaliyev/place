class User < ActiveRecord::Base
  has_many :reviews
  validates_presence_of :username, :email, :password
  validates_uniqueness_of :email
  validates :email, format: { with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i, on: :create }
end
