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
