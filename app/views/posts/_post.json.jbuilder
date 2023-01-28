json.extract! post, :id, :course_id, :ptype_id, :title, :url, :content, :user_id, :created_at, :updated_at
json.url post_url(post, format: :json)
