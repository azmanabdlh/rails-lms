class Course < ApplicationRecord
  include Sluggable

  has_many :lessons, class_name: Course.name, foreign_key: :parent_id
  belongs_to :user

  sluggable

  def is_scheduled?
    !(self.started_at.blank? && self.ended_at.blank?)
  end

  def is_upcoming?
    now = Time.current
    now < self.started_at && self.ended_at > now
  end

  def to_param
    slug
  end
end
