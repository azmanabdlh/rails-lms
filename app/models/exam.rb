class Exam < ApplicationRecord
  belongs_to :course

  attribute :options, :json
  attribute :is_answered, :boolean, default: false
  attribute :is_skipped, :boolean, default: false
end
