class Course < ApplicationRecord
  include Sluggable

  sluggable

  has_many :submissions
  has_many :exams, dependent: :destroy
  has_many :lessons, class_name: Course.name, foreign_key: :parent_id, dependent: :destroy

  has_many :enrollments
  belongs_to :user

  scope :mandatory, -> { where(is_mandatory: 1) }
  scope :schedules, -> { where.not(started_at: nil, ended_at: nil) }

  def schedule?
    self.started_at.present? && self.ended_at.present?
  end

  def upcoming?
    now = Time.current
    is_scheduled? ? now < self.started_at && self.ended_at > now : false
  end

  def to_param
    slug
  end
end
