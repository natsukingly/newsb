class Fix
    class << self
        def hello
            puts 'hello world'
        end
        
		def followers_count
			User.all.each do |user|
				if user.followers_count < user.followers.count
					user.followers_count = user.followers.count
				end
			end
		end
		
		def following_count
			User.all.each do |user|
				if user.following_count < user.following.count
					user.following_count = user.following.count
				end
			end
		end
		
    end
    
end
