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

u1 = User.create!(
  name: Faker::Name.name,
  email: Faker::Internet.email,
  password: password
)

c1 = Course.create!(
  title: Faker::Book.title,
  body: "Hello world",
  thumbnail_url: "img.example.com/random.jpg",
  started_at: Time.current + 1.days,
  ended_at: Time.current + 2.days,
  user_id: u1.id
)

c2 = Course.create!(
  title: Faker::Book.title,
  body: "Sub Hello world",
  thumbnail_url: "img.example.com/random.jpg",
  duration: 3600,
  min_score: 300,
  parent_id: c1.id,
  user_id: u1.id
)

# Exam
Exam.create!(
  question_text: Faker::Book.title,
  course_id: c2.id,
  points: 30,
  options: <<~JSON
  [
    {
    "key": "32323489",
    "text_plain": "blablabla",
    "text_plain_html": "<p>blabla</p>",
    "correct": true
    },
    {
    "key": "32323422",
    "text_plain_html": "<p>zzzzzz</p>",
    "text_plain": "zzzzzzzz",
    "correct": false
    },
    {
    "key": "32323489111",
    "text_plain": "bbbbbbb",
    "text_plain_html": "<p>bbbbbb</p>",
    "correct": false
    },
    {
    "key": "32323489123",
    "text_plain": "azazazazaz",
    "text_plain_html": "<p>azazazaz</p>",
    "correct": false
    }
  ]
  JSON
)
