# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

require "faker"
require "bcrypt"

Faker::Config.locale = :id
password = BCrypt::Password.create :password

5.times do
  User.create!(
    name: Faker::Name.name,
    email: Faker::Internet.email,
    password: password
  )
end

Course.create!(
  title: Faker::Book.title,
  body: "Hello world",
  thumbnail_url: "img.example.com/random.jpg",
  started_at: Time.current + 1.days,
  ended_at: Time.current + 2.days,
  duration: 3600,
  min_score: 300,
  parent_id: 0,
  user_id: 1
)
