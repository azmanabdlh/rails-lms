json.partial! "course", course: @course
json.description @course.body
json.lessons do
  json.array! @course.lessons do |l|
    json.partial! "course", course: l
  end
end
