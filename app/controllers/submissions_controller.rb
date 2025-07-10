class SubmissionsController < ApplicationController
  before_action :authorize_submission
  def index
    answer = @submission.answers.index_by { |a| a.exam_id }
    @course = @submission.course

    is_randomize = @course.is_randomize
    @course.exams = @course.exams.shuffle if is_randomize

    @exams = @course.exams.map do |e|
      e.options = e.options.shuffle if is_randomize
      has_answer = answer[e.id].present?
      if has_answer
        e.is_skipped = answer[e.id].is_skipped?
        e.is_answered = answer[e.id].is_answered
      end

      e.options.map do |o|
        my_answer = answer[e.id].option_key if has_answer
        o[:selected] = o["key"].eql?(my_answer) and o["correct"].to_s.downcase.eql?("true")
      end
      e
    end
  end

  private
  def authorize_submission
    id = params[:id]
    @submission = Submission.find(id)

    # note: before action, please to makesure
    # the submission is authorized for current user
  end
end
