json.partial! "course", course: @course
json.description @course.body
json.lessons do
  json.array! @course.lessons do |l|
    json.partial! "course", course: l
    json.exams do
      json.array! l.exams do |e|
        json.question_text e.question_text
        json.question_points e.points

        json.options do
          json.array! e.options do |op|
            json.key_id op.key
            json.text_plain op.text_plain
            json.text_plain_html op.text_plain_html
            json.correct op.correct
          end
        end
      end
    end
  end
end
