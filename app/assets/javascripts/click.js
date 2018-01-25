
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
	
	$('.flex_container').click(function(){
		$('.notice_bar, .alert_bar').hide();	
	});
	
	$(".notice_bar, .alert_bar").click(function(){
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
		original_language = $('.setting_block.language').attr("data-original-language");
		original_country = $('.setting_block.country').attr("data-original-country");
		$('.setting_block.name input[name="user[name]"]').val(original_name);
		$('.setting_block.credential input[name="user[credential]"]').val(original_credential);
		$('.setting_block.about textarea[name="user[about]"]').val(original_about);
		$('.setting_block.language select').val(original_language);
		$('.setting_block.country select').val(original_country);
	});	
	
	$('.edit_content_btn').click(function(){
		$(this).parents('.setting_block').find('.current.content').hide();
		$(this).parents('.setting_block').find('.new.content').show();
	})
	
	$('.post_submit_btn').click(function(){
		
		selected_value = $(this).parents('form').find('select').val();
		if(selected_value == ""){
			$(this).parents('form').find('p.textarea_error_message.category_undecided').show();
			return false;
		}
		letter_count = $(this).parents('form').find('textarea').val().length;
		if(letter_count > 1000){
			$(this).parents('form').find('p.textarea_error_message.too_long').show();
			$(this).parents('form').find('p.textarea_error_message .letter_count').text(letter_count);
			return false;
		}
	});
	
	$('.post_form textarea, .comment_form, .report_form').click(function(){
		$('p.textarea_error_message').hide();
	});
	
	$('.comment_submit_btn').click(function(){
		letter_count = $(this).parents('form').find('textarea').val().length;
		if(letter_count == 0){
			$(this).parents('form').find('p.textarea_error_message.blank').show();
			return false;
		} else if(letter_count > 500){
			$(this).parents('form').find('p.textarea_error_message.too_long').show();
			$(this).parents('form').find('p.textarea_error_message .letter_count').text(letter_count);
			return false;
		}
	});
	
	// setting form validation
	$('.setting_submit_btn').click(function(){
		letter_count = $(this).parents('form').find('input.edit_name_form').val().length;
		if(letter_count == 0){
			$(this).parents('form').find('.setting_block.name .error_message').show();
			return false;
		}
		
		letter_count = $(this).parents('form').find('input.credential_form').val().length;
		if(letter_count > 100){
			$(this).parents('form').find('.setting_block.credential .error_message').show();
			$(this).parents('form').find('.setting_block.credential .error_message .letter_count').text(letter_count);
			return false;
		}
		
		letter_count = $(this).parents('form').find('.about_form').val().length;
		if(letter_count > 1000){
			$(this).parents('form').find('.setting_block.about .error_message ').show();
			$(this).parents('form').find('.setting_block.about .error_message .letter_count').text(letter_count);
			return false;
		}
	});	

	$('.report_submit_btn').click(function(){
		letter_count = $(this).parents('form').find('textarea').val().length;
		if(letter_count == 0){
			$(this).parents('form').find('p.textarea_error_message.blank').show();
			return false;
		} else if(letter_count > 500){
			$(this).parents('form').find('p.textarea_error_message.too_long').show();
			$(this).parents('form').find('p.textarea_error_message .letter_count').text(letter_count);
			return false;
		}
	});
});




