# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)



@default_categories = ["Business", "Tech", "Politics", "Economics", "Market", "Startup", "Sports", "Education", "Lifestyle"]

@default_categories.each do |category|
    Category.create(name: category)
end

@available_languages = { en: "English", ja: "Japanese"}

@available_languages.each do |code, name|
    language = Language.find_by(code: code)
    unless language
        Language.create(code: code, name: name)
    end
end

united_states_language_id = Language.find_by(code: "en").id
japan_language_id = Language.find_by(code: "ja").id

@available_countries = { "United States" => united_states_language_id, "Japan" => japan_language_id}

@available_countries.each do |country, language_id|
    country = Country.find_by(name: country)
    unless country
        Country.create(name: country, language_id: language_id)
    end
end



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