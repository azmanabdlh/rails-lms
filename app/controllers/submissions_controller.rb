class SubmissionsController < ApplicationController
  before_action :authorize_submission, only: [ :index ]
  def index
    @exams = @submission.exams
  end

  def create
    course_id = params[:course_id].to_i
    @my_submission = Current.user.submissions.new(course_id: course_id)
    if @my_submission.save
      render :show, status: :created
    else
      render json: { message: "validation error", errors: @my_submission.errors }, status: :unprocessable_entity
    end
  end

  private

  def authorize_submission
    id = params[:id]
    @submission = Submission.find(id)
  end
end
