
console.log("UNKO");

// infinite scroll
var win = $(window);
var loading = false;
var model = $('#main_contents').attr('class');

win.scroll(function() {
	// for testing
	// console.log("scrolltop" + win.scrollTop());
	// console.log("document" + ($(document).height() - win.height()));
	
	// last number to trigger event before reaching the end of the document
	if ($(document).height() - win.height() < win.scrollTop() + 1500) {
		if (loading){
			return;
		}	
		loading = true;		
	
		switch(model){
			case "posts":
				$.ajax({
					url: "/posts/load_more",
					type: "GET",
					data: {existing_posts : $('#main_contents').find('.post').length },
					dataType: 'script',
				})
				break;
				
			case "articles":
                $.ajax({
                    url: "/categories/#{@category.id}/load_more",
                    type: "GET",
                    data: {existing_articles : $('#main_contents').find('.article').length },
                    dataType: 'script',
                })
				break;
				
			case "tags":
				break;
		}
	}
});
