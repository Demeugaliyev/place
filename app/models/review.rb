class Review < ActiveRecord::Base
  belongs_to :user
  belongs_to :place

  validates :grade, inclusion: { in: 0..5, message: 'Grade should be number from 1 to 5!' }
end
