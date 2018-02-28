$(document).on('turbolinks:load', function() {

	// $('#post_modal').click(function (event) {
	// 	if(!$(event.target).closest('.post_modal_block').length && !$(event.target).is('.post_modal_block')) {
	// 		$("#post_modal").hide();
	// 		$('html').removeClass('stretch');
	// 	}  
	// });
	
	$('.back_modal_btn').click(function(){
		$('.post_url_form_modal').show();
		$('.post_url_form_modal input[type="url"]').val('');
		$('.post_form_modal_via_url').hide();
	});
	
	// post_form from article show page
	$('.show_article_post_modal_btn').click(function () {
		initializeModal();
		initializeTaggedUser()
		$(".article_post_modal_wrapper").show();
		var article_title = $('#selected_article').find('.article_title').text();
		var article_id = $('#selected_article').attr('data-article-id');
		$(".post_form_modal h2.modal_content_title p").text(article_title);
		$(".post_form_modal").find('.target_article_id').val(article_id);
		if(windowWidth < 768){
			$('.flex_container').hide();
		} else{
			$('.post_form textarea').focus();
		}
		return false;
	});
	
	// post_form from header or feed
	$('.show_post_modal_btn').click(function () {
		initializeModal();
		initializeTaggedUser()
		$(".post_modal_wrapper").show();

		if(windowWidth < 768){
			$('.flex_container').hide();
		} else{
			$('.post_url_form input').focus();
		}
		return false;
	});	
	
	// report_post modal
	$('.show_report_modal_btn').click(function () {
		initializeModal();		
		$(".report_modal_wrapper").show();
		var report_type = $(this).attr("data-type");
		var report_target_content = $(this).parents("." + report_type).find('.opinion').text();
		var target_id = $(this).parents("." + report_type).attr("data-" + report_type + "-id");
		$(".report_form").find('.target_id').val(target_id);
		$(".report_form").find('.target_type').val(report_type);
		$(".report_modal").find('h2.modal_content_title p').text("REPORT: " + $.trim(report_target_content));
		if(windowWidth < 768){
			$('.flex_container').hide();
		} else{
			$('.report_form textarea').focus();
		}
		return false;
	});		
	
	
	// comment new
	$('.show_comment_modal_btn').click(function () {
		initializeModal();
		$(".comment_modal_wrapper").show();
		var post_id = $(this).parents(".post").attr("data-post-id");
		var content = $(this).parents(".post").find(".post_opinion").text();
		$(".comment_new_form").find('.target_post_id').val(post_id);
		$(".comment_new_modal").find('h2.modal_content_title p').text("[RE:] " + $.trim(content));
		if(windowWidth < 768){
			$('.flex_container').hide();
		} else{
			$('.comment_new_form textarea').focus();
		}
		return false;
	});	
	
	// edit comment modal
	$('.show_comment_edit_modal_btn').click(function () {
		initializeModal();
		$(".comment_edit_modal_wrapper").show();
		var comment_id = $(this).parents(".comment").attr("data-comment-id");
		var content = $(this).parents(".comment").find(".comment_opinion").text();
		$(".comment_new_form").find('.target_comment_id').val(comment_id);
		$(".comment_new_form").find('textarea').text($.trim(content));
		if(windowWidth < 768){
			$('.flex_container').hide();
		} 
		return false;
	});	
	
	
	// delete post modal	
	$(".post_ddm .delete_btn").click(function(){
		initializeModal();
		$('.delete_post_modal_wrapper').show();
		var post_id = $(this).parents(".post").attr("data-post-id");
		$(".delete_modal").find('.delete_target_post_id').val(post_id);
		if(windowWidth < 768){
			$('.flex_container').hide();
		}
	});	
	
	// delete post modal	
	$(".deactivation_link").click(function(){
		initializeModal();
		$('.delete_user_modal_wrapper').show();
		if(windowWidth < 768){
			$('.flex_container').hide();
		}
	});	
	
	// delete comment modal	
	$(".comment_ddm .comment_delete_btn").click(function(){
		initializeModal();
		$('.delete_comment_modal_wrapper').show();
		var comment_id = $(this).parents(".comment").attr("data-comment-id");
		$(".delete_modal").find('.delete_target_comment_id').val(comment_id);
		if(windowWidth < 768){
			$('.flex_container').hide();
		}
	});	
		
	
	$(".post_ddm .show_article_post_edit_modal_btn").click(function(){
		initializeModal();
		initializeTaggedUserToEdit($(this).parents('.post'));
		var opinion_height = $(this).parents(".post").find(".opinion").css("height");
		var opinion_form_height = parseInt(opinion_height) + 50;
		$(".article_post_edit_form").find("textarea").css("height", opinion_form_height + "px");
		var post_id = $(this).parents(".post").attr("data-post-id");
		var content = $(this).parents(".post").find(".post_opinion").text();
		$(".article_post_edit_form").find('#edit_target_post_id').val(post_id);
		$(".article_post_edit_form").find('textarea').val($.trim(content));
		$(".article_post_edit_form").show();
		if(windowWidth < 768){
			$('.flex_container').hide();
		}
	});	
	
	// $('.modal').click(function(e){
	// 	e.stopPropagation();
	// });
	
	$('.modal_wrapper').click(function (event) {
		if(!$(event.target).closest('.unlock_sns_ddm.ddm').length && !$(event.target).is('.unlock_sns_ddm.ddm')){
			$('.unlock_sns_ddm.ddm').hide();
		}
		
		if(!$(event.target).closest('.modal').length && !$(event.target).is('.modal')) {
			$(".modal_wrapper").hide();
			$('.flex_container').show();
			$('html').removeClass('stretch');
			position = $('.modal_wrapper').attr('data-position');
			$(window).scrollTop(position);
		}  
	});
	
	$('.close_modal_btn, .mobile_modal_back_btn, .cancel_modal_btn').click(function (event) {
		$(".modal_wrapper, .ddm, .mobile_ddm_header").hide();
		$('.flex_container').show();
		$('html').removeClass('stretch');
		position = $('.modal_wrapper').attr('data-position');
		$(window).scrollTop(position);
	});	
	

	function initializeModal(){
		position = $(window).scrollTop();
		$('.modal_wrapper').attr('data-position', position);
		$(".modal_wrapper, .ddm, .mobile_ddm_header").hide();
		$('html').addClass('stretch');
	}
	
	function initializeTaggedUser(){
		//user search form を隠す
		$('.recommended_user_list').show();
		$('.selected_user_title').hide();
		$('.selected_user_list').html('');
		$('.user_search_block').hide();
		$('span.tagged_user_counter').text("0");
		$('span.tagged_user_counter_on_menu').text("0");
		$('span.tagged_user_counter_on_menu').hide();
		$('input.tagged_user_ids').val('');
		$('.user_add_icon').text("+");
		$('.user_sm').removeClass('selected');
		$('.tagged_user_reset_btn').removeClass('on');
		$('.error_message').hide();
		$('.tag_user_btn.form_btn span.opened').hide();
		$('.tag_user_btn.form_btn span.closed').css("display", "flex");
		$('.post_submit_btn').removeClass("disabled");
	}
	function initializeTaggedUserToEdit($post){
		//user search form を隠す
		var already_tagged_users_count = $post.attr('data-tagged-users-count');
		var already_tagged_uesrs_ids = $post.attr('data-tagged-users');
		$('.recommended_user_list').hide();
		$('.user_search_block').hide();
		$('span.tagged_user_counter').text(already_tagged_users_count);
		$('span.tagged_user_counter_on_menu').text(already_tagged_users_count);
		if(already_tagged_users_count != 0){
			$('span.tagged_user_counter_on_menu').show();
			$('input.tagged_user_ids').val(already_tagged_uesrs_ids);
			$('.tagged_user_reset_btn').addClass('on');
		} else {
			$('span.tagged_user_counter_on_menu').hide();
			$('input.tagged_user_ids').val('');
			$('.user_add_icon').text("+");
			$('.user_sm').removeClass('selected');
			$('.tagged_user_reset_btn').removeClass('on');
		}
		$('.error_message').hide();
		$('.tag_user_btn.form_btn span.opened').hide();
		$('.tag_user_btn.form_btn span.closed').css("display", "flex");
		$('.post_submit_btn').removeClass("disabled");
	}
});