
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
		console.log("i am aweosme");
	   $("#post_content").focus(); 
	});
	
	

	
	
	// locales link open close
	
	$('#locale_link').click(function () {
			// ボタンが押されたら、モーダルウィンドウを表示
			$('#locale_ddm').css("display", "flex");
			return false;
	});

	$('body').click(function (event) {
	   if(!$(event.target).closest('#locale_ddm').length && !$(event.target).is('#locale_ddm')) {
		 $("#locale_ddm").hide();
	   }     
	});

	// notifications ddm open close
	
	$('#notification_icon').click(function () {
			// ボタンが押されたら、モーダルウィンドウを表示
			$('#notification_ddm').css("display", "block");
			return false;
	});

	$('body').click(function (event) {
	   if(!$(event.target).closest('#notification_ddm').length && !$(event.target).is('#notification_ddm')) {
		 $("#notification_ddm").hide();
	   }     
	});
	
	
	

});




