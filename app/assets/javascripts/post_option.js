$(document).on('turbolinks:load', function() {

	$('.option_link').click(function () {
			var height = $(this).parents(".post").find('.opinion').css("height");
			$(this).parents(".post").find('.opinion').attr("data-height", height);
			// ボタンが押されたら、モーダルウィンドウを表示
			$(".ddm").hide();
			$(this).parents(".post").find('.post_ddm').css("display", "flex");
			
			return false;
	});
	
	$('body').click(function (event) {
	  if(!$(event.target).closest('.post_ddm').length && !$(event.target).is('.post_ddm')) {
		 $(".post_ddm").hide();
	  }     
	});




	$(".post_ddm .delete_btn").click(function(){
	   $('.delete_post_modal_wrapper').fadeIn();
	   $('')
	   return false;
	});
	
	$(".post_ddm .report_btn").click(function(){
	   $(this).parents(".post_ddm").find(".report_post_modal_wrapper").fadeIn();
	});
	
	
	// $('.post_ddm .option_modal').click(function (event) {
	// 	if(!$(event.target).closest('.delete').length && !$(event.target).is('.delete')) {
	// 		if(!$(event.target).closest('.report').length && !$(event.target).is('.report')) {
	// 			$(".option_modal").hide();
	// 			$(".option_modal .report").hide();
	// 			$(".option_modal .delete").hide();
	// 			$(".post_ddm").hide();
	// 		}
	// 	}     
	// });
	
	// $('.post_ddm .option_modal .cancel_btn').click(function(){
	// 	$(".option_modal").hide();
	// 	$(".option_modal .report").hide();
	// 	$(".option_modal .delete").hide();
	// 	$(".post_ddm").hide();	
	// });
});		
		