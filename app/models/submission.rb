class Submission < ApplicationRecord
  belongs_to :course
  belongs_to :user

  has_many :answers
end
