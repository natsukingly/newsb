json.extract! post, :id, :user_id, :title, :content, :article_title, :article_image, :article_url, :created_at, :updated_at
json.url post_url(post, format: :json)
