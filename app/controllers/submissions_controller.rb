class SubmissionsController < ApplicationController
  before_action :authorize_submission
  def index
    answer = @submission.answers.index_by { |a| a.exam_id }

    @exams = @submission.course.exams.map do |e|
      is_answered = answer[e.id].present? ? answer[e.id].is_answered : false
      e.is_answered = is_answered

      if is_answered
        e.options.map do |o|
          my_answer = answer[e.id].option_key
          e.is_correct = o["key"].eql?(my_answer)
          e.my_answer = my_answer
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
