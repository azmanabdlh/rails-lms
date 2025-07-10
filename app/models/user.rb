class User < ApplicationRecord
  has_secure_password

  has_many :submissions
  has_many :enrollments
end
