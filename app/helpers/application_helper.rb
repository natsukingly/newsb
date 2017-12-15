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
            return asset_path "no_image.jpeg"
        end
    end
    
    def user_image_helper(user)
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
      {
        site: "NEWSB",
        reverse: true,
        title: "NEWSB",
        description: "Share knowledge, ask questions, and report fake news.",
        keywords: "",
        og: {
          title: :title,
          type: "website",
          url: request.original_url,
          site_name: "NEWSB",
          description: :description,
        }
      }
    end
    
    def article_meta_tags(article)
        {
            title: article.title,
            description: "NEWSB: The most social news platform in the world",
            image_src: "#{url_for(asset_path article.image.url || "no_image.jpeg")}",
            keywords: "",
            og: {
              title: :title,
              type: "article",
              url: "https://news-party-natsukingly.c9users.io/#{article.country.name}/articles/#{article.id}",
              image: "#{url_for(asset_path article.image.url || "no_image.jpeg")}",
              site_name: "NEWSB",
              description: :description,
            },
            twitter: {
                card: "summary_large_image",
                site: "NEWSB",
                creater: "NEWSB",
                title: :title,
                description: :description,
                image: "#{url_for(asset_path article.image.url || "no_image.jpeg")}",
            }
        }
    end
    
    
    
    
    TIME_PATTERN = { ' months'=>'mo', ' hours'=>'h', ' minutes'=>'m', ' days'=>'d', ' seconds' => 's', ' month'=>'mo', ' hour'=>'h', ' minute'=>'m', ' day'=>'d', ' second' => 's'}
    # or make use of locale:
    # TIME_PATTERN = {' hour'=> I18n.t('h'), ' minute'=> I18n.t('m'), ' day'=> I18n.t('d'), ' hours'=> I18n.t('h'), ' minutes'=> I18n.t('m'), ' days'=> I18n.t('d')}
    
    def time_ago_in_words_short(time)
        if time == nil
            word = " "
        else
            word = time_ago_in_words(time)
            TIME_PATTERN.each_pair{ |k, v| word.gsub!(k, v) }
        end
        word
    end
     
end
