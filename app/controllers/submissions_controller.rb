class SubmissionsController < ApplicationController
  before_action :authorize_submission
  def index
    @exams = @submission.my_exams
  end

  private
  def authorize_submission
    id = params[:id]
    @submission = Submission.find(id)

    # note: before action, please to makesure
    # the submission is authorized for current user
  end
end
