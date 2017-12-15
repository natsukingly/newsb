$(document).on('turbolinks:load', function() {
	$(".post_ddm .delete_btn").click(function(){
	   $(this).parents(".post_ddm").find(".option_modal").fadeIn();
	   $(this).parents(".post_ddm").find(".delete").show();
	});
	$(".post_ddm .report_btn").click(function(){
	   $(this).parents(".post_ddm").find(".option_modal").fadeIn();
	   $(this).parents(".post_ddm").find(".report").show();
	});
	
	
	$(".post_ddm .edit_btn").click(function(){
	   var opinion_height = $(this).parents(".post").find(".opinion").css("height");
	   var opinion_form_height = parseInt(opinion_height) - 20
	   $(this).parents(".post").find(".edit_form .edit_textarea").css("height", opinion_form_height + "px");
	   $(this).parents(".post").find(".edit_form").fadeIn();
	   $(this).parents(".post").find(".opinion").hide();
	   $(".post_ddm").hide();
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
		