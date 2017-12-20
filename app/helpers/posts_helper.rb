module PostsHelper
    def render_with_hashtags(body)
        hashtag_regex = /[#＃][Ａ-Ｚａ-ｚA-Za-z一-鿆0-9０-９ぁ-ヶｦ-ﾟー]+/
        body.gsub(hashtag_regex){|word| link_to word, "#{tag_path(word.downcase.delete('#').delete('＃'))}", class: "tag_link"}.html_safe

    end
end
