class SubmissionsController < ApplicationController
  before_action :authorize_submission
  def index
    answer = @sub.answers.index_by { |a| a.exam_id }

    @exams = @sub.course.exams.map do |e|
      is_answered = not answer[e.id].blank?
      e.is_answered = is_answered

      e.options.map do |o|
        my_answer = is_answered ? o["key"].eql?(answer[e.id].option_key) : false
        o[:my_answer] = my_answer
      end
      e
    end
  end

  private
  def authorize_submission
    id = params[:id]
    @sub = Submission.find(id)

    # note: before action, please to makesure
    # the submission is authorized for current user
  end
end
