class CoursesController < ApplicationController
  def index
    @courses = Course.where(parent_id: nil)
  end

  def show
    @course = Course.find_by(slug: params[:id])
    render json: { message: "course not found" }, status: :not_found if @course.blank?
  end
end
