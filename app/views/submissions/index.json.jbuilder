json.course do
  json.partial! "courses/course", course: @sub.course
  json.exams do
    json.array! @exams do |e|
      json.question_text e.question_text
      json.is_answered e.is_answered
      json.is_correct e.is_correct
      json.my_answer e.my_answer
      json.question_points e.points
      json.question_options e.options
    end
  end
end
