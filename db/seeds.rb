# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)



# @default_categories = { 1 => "Business", 2 => "Tech", 3 => "Politics", 4 => "Economics", 5 => "Market", 6 => "Startup", 7 => "Sports", 8 => "Education", 9 => "Lifestyle"}

# @default_categories.each do |id, category|
#     category = Category.find(id)
#     if category.nil?
#         category_item = Category.new(name: category[1])
#         category_item.save
#     else
#         category.update(name: category)
#     end
# end

Category.find_or_create_by(name: "Business", ja_name: "ビジネス")
Category.find_or_create_by(name: "Tech", ja_name: "テクノロジー")
Category.find_or_create_by(name: "Politics", ja_name: "政治")
Category.find_or_create_by(name: "Entertainment", ja_name: "エンタメ")
Category.find_or_create_by(name: "Sports", ja_name: "スポーツ")
Category.find_or_create_by(name: "Funny", ja_name: "おもしろ")
Category.find_or_create_by(name: "Startup", ja_name: "スタートアップ")
Category.find_or_create_by(name: "Food", ja_name: "グルメ")
Category.find_or_create_by(name: "Movies・Music", ja_name: "映画・音楽")
Category.find_or_create_by(name: "Health", ja_name: "美容・健康")
Category.find_or_create_by(name: "Relationships", ja_name: "人間関係")
Category.find_or_create_by(name: "Web", ja_name: "デザイン・開発")



# @available_languages = { en: "English", ja: "Japanese"}

# @available_languages.each do |code, name|
#     language = Language.find_by(code: code)
#     if language.nil?
#         Language.create(code: code, name: name)
#     end
# end

Language.find_or_create_by(name: "English", code: "en")
Language.find_or_create_by(name: "Japanese", code: "ja")


Country.find_or_create_by(name: "United States", language_id: Language.find_by(code: "en").id)
Country.find_or_create_by(name: "Japan", language_id: Language.find_by(code: "ja").id)




# 5.times do
    
    # business
#   	Post.create(content: "aad!!!!!!" , article_title: "fuck", article_image: "", article_url: "",article_site: "font awesome", user_id: 12)
#   	Article.create()
  	
  	#politics
#   	Post.create
  	
  	#entertainment
  	
  	#sports
  	
  	#health
  	
  	#tech
  	
  	#education
  	
  	#others
# end