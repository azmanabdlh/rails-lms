class Answer < ApplicationRecord
  belongs_to :exam
  belongs_to :submission

  # validate is answered by user
  before_save { self.is_answered = self.option_key.present? }

  def is_skipped?
    self.exam_id > 0 and self.is_answered == false
  end
end
