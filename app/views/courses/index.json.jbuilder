json.array! @courses do |c|
  json.partial! "course", course: c
end
