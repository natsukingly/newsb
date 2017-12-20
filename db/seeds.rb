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

Category.find_or_create_by(name: "Business")
Category.find_or_create_by(name: "Tech")
Category.find_or_create_by(name: "Politics")
Category.find_or_create_by(name: "Economy")
Category.find_or_create_by(name: "Market")
Category.find_or_create_by(name: "Startup")
Category.find_or_create_by(name: "Sports")
Category.find_or_create_by(name: "Education")
Category.find_or_create_by(name: "Lifestyle")


@available_languages = { en: "English", ja: "Japanese"}

@available_languages.each do |code, name|
    language = Language.find_by(code: code)
    if language.nil?
        Language.create(code: code, name: name)
    end
end


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