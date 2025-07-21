class SubmissionsController < ApplicationController
  before_action :authorize_submission
  def index
    @exams = @submission.exams
  end

  def create
    submission = Current.user.submission.new(
      course_id: params[:course_id],
      started_at: Time.current,
    )
    if submission.save
      render :show, status: :created
    else
      render json: { message: "invalid create submission", errors: submission.errors }, status: :unprocessable_entity
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
