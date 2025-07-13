class Submission < ApplicationRecord
  belongs_to :course
  belongs_to :user

  has_many :answers

  def my_exams(*args)
    opts = args.extract_options!
    randomize = opts[:randomize].present? ? true : false

    ans = self.answers.index_by { |a| a.exam_id }
    # set shuffle the exams
    self.course.exams = self.course.exams.shuffle if randomize
    self.course.exams.map do |exam|
      has_ans = ans[exam.id].present?
      exam.options = exam.options.map do |op|
        o = Exam::Option.new
        o.from_json(op.to_json)
        o.my_answered?(ans[exam.id].option_key) if has_ans

        o.as_json
      end

      exam.is_answered = ans[exam.id].is_answered if has_ans
      exam.is_skipped = ans[exam.id].is_skipped? if has_ans

      # return mapped
      exam
    end
  end
end
