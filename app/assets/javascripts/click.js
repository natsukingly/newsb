
$(document).on('turbolinks:load', function() {
	
	$('.cancel_btn').click(function(){
		$(this).parents('.comment_form').hide();
		$(this).parents('.post').find('.invite_comment').show();
	});
	
	$('.comment_link').click(function(){

		$(this).parents('.post').find('.comment_form').show();
		$(this).parents('.post').find('.comment_form textarea').focus();
		$(this).parents('.post').find('.invite_comment').hide();
	});

	
	
	// articles/show post_form form_no_category
	$(".post_form .post_textarea_block").click(function(){
		if(!($(this).hasClass('not_logged_in'))){
			$(this).find("#post_content").focus(); 
		}
	});

	$('.best_post_btn').click(function(event){
		event.stopPropagation();
		if($(this).hasClass('open')){
			$(this).removeClass('open');
			$(this).html('<i class="fa fa-angle-down fa-fw open_icon"></i><span>Best post</span>');
			$(this).parents('.article').find('.best_post').hide();
			return false;
		} else {
			$(this).addClass('open');
			$(this).html('<i class="fa fa-times fa-fw">');
			$(this).parents('.article').find('.best_post').fadeIn();
			return false;
		}
		return false;
	});
	
	$('body').click(function (event) {
		if(!$(event.target).closest('.ddm_wrapper').length && !$(event.target).is('.ddm_wrapper')) {
			$(".ddm").hide();
			$('body').removeClass('fixed');
		}     
	});	
	
	$(".notice_bar").click(function(){
		$(this).hide();	
	});
});




