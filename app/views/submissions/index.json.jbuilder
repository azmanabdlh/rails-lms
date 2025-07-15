json.course do
  json.partial! "courses/course", course: @submission.course
  json.exams do
    json.array! @exams do |e|
      json.question_text e.question_text
      json.is_answered e.answered?
      json.is_skipped e.skipped?
      json.question_points e.points

      json.options do
        json.array! e.options do |op|
          json.key_id op.key
          json.text_plain op.text_plain
          json.text_plain_html op.text_plain_html
          json.selected op.selected
          json.correct op.correct
        end
      end
    end
  end
end
