json.extract! course, :id, :university_id, :name, :created_at, :updated_at
json.url course_url(course, format: :json)
