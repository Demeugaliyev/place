class Review < ActiveRecord::Base
  MIN_RATING_WITHOUT_COMMENT = 4

  belongs_to :user
  belongs_to :place
  
  validates :grade, inclusion: { in: 0..5 }
  validates :comment, presence: true, if: :need_comment?
  
  def need_comment?
    grade < MIN_RATING_WITHOUT_COMMENT
  end
end
