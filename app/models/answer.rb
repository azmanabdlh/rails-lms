class Answer < ApplicationRecord
  belongs_to :exam
  belongs_to :submission

  def is_answered
    (self.option_key.present? && self.created_at.present?)
  end
end
