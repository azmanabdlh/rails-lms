class SubmissionsController < ApplicationController
  before_action :authorize_submission
  def index
    answer = @submission.answers.index_by { |a| a.exam_id }

    @exams = @submission.course.exams.map do |e|
      e.is_answered = answer[e.id].present? ? answer[e.id].is_answered : false
      if e.is_answered
        e.options.map do |o|
          my_answer = answer[e.id].option_key
          o[:my_answer] = o["key"].eql?(my_answer) && o["correct"].to_s.downcase.eql?("true")
        end
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
