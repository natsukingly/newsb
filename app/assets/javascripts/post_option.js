$(document).on('turbolinks:load', function() {
	$(".post_ddm .delete_btn").click(function(){
	   $(this).parents(".post_ddm").find(".option_modal").fadeIn();
	   $(this).parents(".post_ddm").find(".delete").show();
	});
	$(".post_ddm .report_btn").click(function(){
	   $(this).parents(".post_ddm").find(".option_modal").fadeIn();
	   $(this).parents(".post_ddm").find(".report").show();
	});
	
	

	
	$('.post_ddm .option_modal').click(function (event) {
		if(!$(event.target).closest('.delete').length && !$(event.target).is('.delete')) {
			if(!$(event.target).closest('.report').length && !$(event.target).is('.report')) {
				$(".option_modal").hide();
				$(".option_modal .report").hide();
				$(".option_modal .delete").hide();
				$(".post_ddm").hide();
			}
		}     
	});
	
	$('.post_ddm .option_modal .cancel_btn').click(function(){
		$(".option_modal").hide();
		$(".option_modal .report").hide();
		$(".option_modal .delete").hide();
		$(".post_ddm").hide();	
	});
});		
		