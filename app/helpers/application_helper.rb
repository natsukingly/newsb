module ApplicationHelper
    
    def universal_truncate(words)
        result = words.match(/[^\x01-\x7E]/)
        if result.nil?
            truncate(words, length: 80, separator: ' ')
        else
            if result.length < 10
                truncate(words, length: 80, separator: ' ')
            else
                truncate(words, length: 40, separator: ' ')
            end
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
