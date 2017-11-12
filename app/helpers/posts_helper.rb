module PostsHelper
    def render_with_hashtags(body)
        body.gsub(/#\w+/){|word| link_to word, "/tags/#{word.downcase.delete('#')}", class: "tag_link"}.html_safe
    end
end
