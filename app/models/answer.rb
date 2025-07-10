class Answer < ApplicationRecord
  belongs_to :exam
  belongs_to :submission

  # validate is answered by user
  before_save { self.is_answered = self.option_key.present? }
end
