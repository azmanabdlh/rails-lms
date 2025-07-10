json.partial! "course", course: @course
json.description @course.body
json.lessons do
  json.array! @course.lessons do |l|
    json.partial! "course", course: l
    json.exams do
      json.array! l.exams do |e|
        json.question_text e.question_text
        json.question_points e.points
        json.question_options e.options
      end
    end
  end
end
