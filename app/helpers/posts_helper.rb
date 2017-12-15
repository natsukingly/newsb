module PostsHelper
    def render_with_hashtags(body)
        hashtag_regex = /[#|＃]\w*[一-龠_ぁ-ん_ァ-ヴーａ-ｚＡ-Ｚa-zA-Z0-9]+|[#|＃]\[a-zA-Z0-9_]+|[#|＃]\[a-zA-Z0-9_]/
        body.gsub(hashtag_regex){|word| link_to word, "#{tag_path(word.downcase.delete('#').delete('＃'))}", class: "tag_link"}.html_safe
    end
end
