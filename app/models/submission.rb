class Submission < ApplicationRecord
  belongs_to :course
  belongs_to :user

  has_many :answers

  validates :course, presence: true
  validates :user, presence: true
  validates :started_at, presence: true

  before_save { self.started_at = Time.current }

  def exams(*args)
    opts = args.extract_options!
    randomize = opts[:randomize].present? ? true : false

    answered = self.answers.index_by { |a| a.exam_id }
    self.course.exams = self.course.exams.shuffle if randomize

    self.course.exams.map do |exam|
      has_answer = answered[exam.id].present?
      exam.options = exam.options.map { |op| op.mark_as_selected(answered[exam.id].option_key) } if has_answer
      exam
    end
  end
end
