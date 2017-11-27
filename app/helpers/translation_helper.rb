module TranslationHelper
    def country_name_helper(country)
        case country
        when "United States" then
          t('country.united_states')
        when "Japan" then
          t('country.japan')
        end    
    end
    
    def language_name_helper(language)
        case language
        when "English" then
          "English"
        when "Japanese" then
          "日本語"
        end    
    end
end