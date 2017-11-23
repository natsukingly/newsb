
$(document).on('turbolinks:load', function() {
	
	$('.cancel_btn').click(function(){
		$(this).parents('.comment_form').hide();
		$(this).parents('.post').find('.invite_comment').show();
	});
	
	$('.comment_link').click(function(){
		console.log("clicked");
		$(this).parents('.post').find('.comment_form').show();
		$(this).parents('.post').find('.comment_form textarea').focus();
		$(this).parents('.post').find('.invite_comment').hide();
	});

	
	
	// articles/show post_form form_no_category
	$("#post_form .textarea").click(function(){
	   $(this).find("#post_content").focus(); 
	});
	

	$('.best_post_btn').click(function(event){
		event.stopPropagation();
		console.log(this);
		if($(this).hasClass('open')){
			$(this).removeClass('open');
			$(this).text("Best post");
			$(this).parents('.article').find('.best_post').slideUp();
			return false;
		} else {
			$(this).addClass('open');
			$(this).text("close");
			$(this).parents('.article').find('.best_post').slideDown();
			return false;
		}
		return false;
	});
	
	
	$(".notice_bar").click(function(){
		$(this).hide();	
	});
	
});




