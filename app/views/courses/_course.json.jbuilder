json.id course.id
json.title course.title
json.duration course.duration
json.min_passed_score course.min_score
json.thumbnail_url course.thumbnail_url
json.is_mandatory course.is_mandatory
json.is_randomize course.is_randomize
json.is_upcoming course.upcoming?
json.is_scheduled course.schedule?
json.started_at course.started_at
json.ended_at course.ended_at
json.teacher do
  json.teacher_id course.user_id
  json.name course.user.name
end
json.url url_for(course)

json.created_at course.created_at
json.updated_at course.updated_at
