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
});