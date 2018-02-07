module ApplicationHelper
    
    def universal_truncate(words, volume)
        result = words.scan(/[^\x01-\x7E]/)
        # 全角だった場合
        if result.nil?
            truncate(words, length: volume / 2)
        else
            if result.length < 5
                # 半角だった場合
                truncate(words, length: volume, separator: ' ')
            else
                # 全角だった場合
                truncate(words, length: volume / 2)
            end
        end
    end
    
    
    def universal_truncate_with_omission(words, volume, omission)
        result = words.scan(/[^\x01-\x7E]/)
        # 全角だった場合
        if result.nil?
            truncate(words, length: volume / 2, omission: omission)
        else
            if result.length < 5
                # 半角だった場合
                truncate(words, length: volume, separator: ' ', omission: omission)
            else
                # 全角だった場合
                truncate(words, length: volume / 2, omission: omission)
            end
        end
    end
    
    def article_image_helper(url)
        if url && url != ""
            url
        else 
            return "/images/no_image.jpeg"
        end
    end
    
    def user_image_helper(user)
        if user && user.image.url.nil? == false
            image_tag user.image.profile_sm.url, class: "img-circle"
        elsif user
            render 'svg/user_icon_sub'
        end
    end
    
    def user_image_md_helper(user)
        if user && user.image.url.nil? == false
            image_tag user.image.profile_md.url, class: "img-circle"
        elsif user
            render 'svg/user_icon_sub'
        end
    end       
    
    def user_image_lg_helper(user)
        if user && user.image.url.nil? == false
            image_tag user.image.url, class: "img-circle"
        elsif user
            render 'svg/user_icon_sub'
        end
    end    
           
    def resource_name
        :user
    end
    
    def resource
        @resource ||= User.new
    end
    
    def devise_mapping
        @devise_mapping ||= Devise.mappings[:user]
    end            
        
    def default_meta_tags
        if Rails.env.development?
          {
            # site: "newsb!",
            "google-site-verification" => "mKpyaltoD8JmVXTMskfu7YXb5soQsBaUGS39Zd71QfE",
            reverse: true,
            title: "Newsb!",
            description: "Newsb! みんなで考えるニュース",
            keywords: "",
            viewport: "width=device-width, initial-scale=1.0" ,
            fa: {
                app_id: ENV['FACEBOOK_KEY']
            },
            og: {
              title: :title,
              type: "website",
              url: request.original_url,
              image: "https://news-party-natsukingly.c9users.io/images/newsb_image.png",
              site_name: "newsb!",
              description: :description,
            }
          }
        elsif Rails.env.production?
          {
            # site: "newsb!",
            "google-site-verification" => "mKpyaltoD8JmVXTMskfu7YXb5soQsBaUGS39Zd71QfE",
            reverse: true,
            title: "Newsb!",
            description: "Newsb! みんなで考えるニュース",
            keywords: "",
            viewport: "width=device-width, initial-scale=1.0" ,
            fa: {
                app_id: ENV['FACEBOOK_KEY']
            },
            og: {
              title: :title,
              type: "website",
              url: request.original_url,
              image: "http://www.newsbeee.com/images/newsb_image.png",
              site_name: "Newsb!",
              description: :description,
            }
          }
        end
    end
    
    def article_meta_tags(article)
        if Rails.env.development?
            {
                title: article.title,
                description: "Newsb! みんなで考えるニュース",
                image_src: article.image.url || "https://news-party-natsukingly.c9users.io/images/newsb_image.png",
                keywords: "",
                fa: {
                    app_id: ENV['FACEBOOK_KEY']
                },
                og: {
                  title: :title,
                  type: "article",
                  url: "https://news-party-natsukingly.c9users.io/#{article.country.name}/articles/#{article.id}",
                  image: article.image.url || "https://news-party-natsukingly.c9users.io/images/newsb_image.png",
                  site_name: "Newsb!",
                  description: :description,
                },
                twitter: {
                    card: "summary_large_image",
                    site: "Newsb!",
                    creater: "Newsb!",
                    title: :title,
                    description: :description,
                    image: article.image.url || "https://news-party-natsukingly.c9users.io/images/newsb_image.png",
                }
            }
        elsif Rails.env.production?
            {
                title: article.title,
                description: "Newsb! みんなで考えるニュース",
                image_src: article.image.url || "http://www.newsbeee.com/images/newsb_image.png",
                keywords: "",
                fa: {
                    app_id: ENV['FACEBOOK_KEY']
                },
                og: {
                  title: :title,
                  type: "article",
                  url: "http://www.newsbeee.com/#{article.country.name}/articles/#{article.id}", 
                  image: article.image.url || "http://www.newsbeee.com/images/newsb_image.png",
                  site_name: "Newsb!",
                  description: :description,
                },
                twitter: {
                    card: "summary_large_image",
                    site: "Newsb!",
                    creater: "Newsb!",
                    title: :title,
                    description: :description,
                    image: article.image.url || "http://www.newsbeee.com/images/newsb_image.png",
                }
            }
        end
    end
    
    def articles_count_by_category(category_name, country_id)
 		Article.all.where(category_id: Category.find_by(name: category_name).id, country_id: country_id).where("published_time >= ?", Time.now.ago(2.days)).where.not(posts_count: 0).count
    end

    def admin_auto_post_record(site_name)
        records = AutoPostRecord.where(site_name: site_name)
    	if AutoPostRecord.where(site_name: site_name).any?
    		"#{time_ago_in_words(records.last.created_at)}/#{records.last.shared}"
    	end
    end

    # def time_ago_in_words_short(time)
    #     if time == nil
    #         word = " "
    #     else
    #         word = time_ago_in_words(time)
    #         TIME_PATTERN.each_pair{ |k, v| word.gsub!(k, v) }
    #     end
    #     word
    # end
     
end
