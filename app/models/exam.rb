class Exam < ApplicationRecord
  belongs_to :course

  attribute :options, :json
  attribute :is_answered, :boolean, default: false
  attribute :is_correct, :boolean, default: false
  attribute :my_answer, :string
end
