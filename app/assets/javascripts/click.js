
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
	
	$('.flex_container').click(function (event) {
		if(!$(event.target).closest('.ddm_wrapper').length && !$(event.target).is('.ddm_wrapper')) {
			$(".ddm").hide();
			$('body').removeClass('fixed');
		}     
	});	
	
	$(".notice_bar").click(function(){
		$(this).hide();	
	});
	
	$('.setting_menu_btn').click(function(){
		console.log('aiueo');
		if($(this).hasClass("open")){
			$(this).removeClass("open");
			$(this).find("i").removeClass("fa-angle-up").addClass("fa-angle-down");
			$(this).parents(".profile_option_block").find(".setting_menu").slideUp().css("display", "block");
			return false;
		} else {
			$(this).addClass("open");
			$(this).find("i").removeClass("fa-angle-down").addClass("fa-angle-up");
			$(this).parents(".profile_option_block").find(".setting_menu").slideDown();
			return false;
		}
	});
	
	
	// edit setting js
	$('#reset_setting_btn').click(function(){
		original_name = $('.setting_block.name').attr("data-original-name");
		original_credential = $('.setting_block.credential').attr("data-original-credential");
		original_about = $('.setting_block.about').attr("data-original-about");
		$('.setting_block.name input[name="user[name]"]').val(original_name);
		$('.setting_block.credential input[name="user[credential]"]').val(original_credential);
		$('.setting_block.about textarea[name="user[about]"]').val(original_about);
	});	
	
	$('.edit_content_btn').click(function(){
		$(this).parents('.setting_block').find('.current.content').hide();
		$(this).parents('.setting_block').find('.new.content').show();
	})
	
	
});




