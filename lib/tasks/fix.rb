class Fix
	require File.expand_path(File.dirname(__FILE__) + "/environment")
    class << self
        def hello
            puts 'hello world'
        end
        
		def followers_count
			User.all.find_each do |user|
				if user.followers_count < user.followers.count
					user.followers_count = user.followers.count
					user.save
				end
			end
		end
		
		def following_count
			User.all.find_each do |user|
				if user.following_count < user.following.count
					user.following_count = user.following.count
					user.save
				end
			end
		end
		
    end
    
end
