
[1mFrom:[0m /home/ubuntu/workspace/news_party/app/controllers/posts_controller.rb @ line 270 PostsController#create_article_and_post:

    [1;34m251[0m: [32mdef[0m [1;34mcreate_article_and_post[0m
    [1;34m252[0m: 	@article = [1;34;4mArticle[0m.where([35mcountry_id[0m: @country.id).find_by([35mtitle[0m: params[[33m:article[0m][[33m:title[0m]) || [1;34;4mArticle[0m.where([35mcountry_id[0m: @country.id).find_by([35murl[0m: params[[33m:article[0m][[33m:url[0m])
    [1;34m253[0m: 
    [1;34m254[0m: 	[1;34m#save an article only when it doesnt already exist[0m
    [1;34m255[0m: 	[32mif[0m @article == [1;36mnil[0m
    [1;34m256[0m: 		@article = [1;34;4mArticle[0m.new(article_params)
    [1;34m257[0m: 		[32mif[0m params[[33m:article[0m][[33m:image[0m].to_s == [31m[1;31m"[0m[31mno_image[1;31m"[0m[31m[0m
    [1;34m258[0m: 			@article.image = [31m[1;31m"[0m[31mno_image.jpeg[1;31m"[0m[31m[0m
    [1;34m259[0m: 		[32melse[0m
    [1;34m260[0m: 			@article.remote_image_url = params[[33m:article[0m][[33m:image[0m]
    [1;34m261[0m: 		[32mend[0m
    [1;34m262[0m: 		@article.category_id = params[[33m:post[0m][[33m:category_id[0m].to_i
    [1;34m263[0m: 		@article.country_id = @country.id
    [1;34m264[0m: 
    [1;34m265[0m: 	[32mend[0m
    [1;34m266[0m: 	
    [1;34m267[0m: 	[1;34m#save post[0m
    [1;34m268[0m: 	@post = current_user.posts.build([35marticle_id[0m: @article.id)
    [1;34m269[0m: 	@post.category_id = params[[33m:post[0m][[33m:category_id[0m].to_i
 => [1;34m270[0m: 	@post.country_id = @country.id
    [1;34m271[0m: 	@post.content = params[[33m:post[0m][[33m:content[0m]
    [1;34m272[0m: 	@post.fake_news_report = params[[33m:post[0m][[33m:fake_news_report[0m] || [1;36mfalse[0m
    [1;34m273[0m: 	@post.save
    [1;34m274[0m: 	
    [1;34m275[0m: 	decide_category
    [1;34m276[0m: [32mend[0m

