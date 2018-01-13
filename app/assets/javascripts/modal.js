$(document).on('turbolinks:load', function() {

	// $('.show_post_modal_btn.on_feed').click(function () {
  //      var position = $('.post_url_form.on_feed').offset();
  //      var width = $('.post_section').width();
  //      if(windowWidth >= 768){
  //  		$('#post_modal .post_modal_block').css("position", "absolute").css("left", position.left).css("top", 50).css("width", width + "px");
  //  	} else{
  //  		$('#post_modal .post_modal_block').css("position", "absolute").css("left", position.left).css("top", 0).css("width", width + "px");
  //  	}
		// $("#post_modal").fadeIn();
		// $('body').addClass('fixed');
		// $('#placeholder_url').focus();
	// 	return false;
	// });
	
	// $('.show_post_modal_via_article_btn').click(function () {
	// 	$(".post_modal_wrapper_via_article").fadeIn();
	// 	$('body').addClass('fixed');
	// 	$('#placeholder_url').focus();
	// 	return false;
	// });

	$('#post_modal').click(function (event) {
		if(!$(event.target).closest('.post_modal_block').length && !$(event.target).is('.post_modal_block')) {
			$("#post_modal").hide();
			$('body').removeClass('fixed');
		}  
	});
	
	$('.close_modal_btn, .mobile_modal_back_btn').click(function (event) {
		$(".modal_wrapper").hide();
		$('.sub_function_wrapper').show();
		$('body').removeClass('fixed');
	});	
	
	$('.back_modal_btn').click(function(){
		$('.post_url_form_modal').show();
		$('.post_url_form_modal input[type="url"]').val('');
		$('.post_form_modal').hide();
	});
	
	
	
	// post_form from article show page
  	$('.show_article_post_modal_btn').click(function () {
		$(".article_post_modal_wrapper").fadeIn();
		$('body').addClass('fixed');
		if(windowWidth < 768){
			$('.sub_function_wrapper').hide();
		}
		return false;
	});
	
	// post_form from header or feed
  	$('.show_post_modal_btn').click(function () {
		$(".post_modal_wrapper").fadeIn();
		$('body').addClass('fixed');
		if(windowWidth < 768){
			$('.sub_function_wrapper').hide();
		}
		return false;
	});	
	
	
	
	$(".post_ddm .edit_btn").click(function(){
	   var opinion_height = $(this).parents(".post").find(".opinion").css("height");
	   var opinion_form_height = parseInt(opinion_height) + 50;
	   $(".article_post_edit_form").find("textarea").css("height", opinion_form_height + "px");
	   
	   var post_id = $(this).parents(".post").attr("data-post-id");
	   var content = $(this).parents(".post").find(".opinion").text();
	   $(".article_post_edit_form").find('#edit_target_post_id').val(post_id);
	   $(".article_post_edit_form").find('textarea').val($.trim(content));
	   if(windowWidth < 768){
			$('.sub_function_wrapper').hide();
		}
	   $(".article_post_edit_form").fadeIn();
	  
	   
	   $(".post_ddm").hide();
	});	
	
	// $('.modal').click(function(e){
	// 	e.stopPropagation();
	// });
	
	$('.modal_wrapper').click(function (event) {
		if(!$(event.target).closest('.modal').length && !$(event.target).is('.modal')) {
			$(".modal_wrapper").hide();
			$('.sub_function_wrapper').show();
			$('body').removeClass('fixed');
		}  
	});
	
});