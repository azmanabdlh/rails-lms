class Course < ApplicationRecord
  include Sluggable

  sluggable

  has_many :submissions
  has_many :exams, dependent: :destroy
  has_many :lessons,
    class_name: Course.name,
    foreign_key: :parent_id,
    dependent: :destroy

  has_many :enrollments

  belongs_to :user

  def is_scheduled?
    self.started_at.present? && self.ended_at.present?
  end

  def is_upcoming?
    now = Time.current
    is_scheduled? ? now < self.started_at && self.ended_at > now : false
  end

  def to_param
    slug
  end
end
