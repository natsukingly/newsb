$(document).on('turbolinks:load', function() {

	$('.show_post_modal_btn.on_feed').click(function () {
        var position = $('.post_url_form.on_feed').offset();
        var width = $('.post_section').width();
    	$('#post_modal .post_modal_block').css("position", "absolute").css("left", position.left).css("top", 50).css("width", width + "px");
		$("#post_modal").fadeIn();
		$('body').addClass('fixed');
		$('#placeholder_url').focus();
		return false;
	});
	
	$('.show_post_modal_btn').click(function () {
		$("#post_modal").fadeIn();
		$('body').addClass('fixed');
		$('#placeholder_url').focus();
		return false;
	});

	$('#post_modal').click(function (event) {
		if(!$(event.target).closest('.post_modal_block').length && !$(event.target).is('.post_modal_block')) {
			$("#post_modal").hide();
			$('body').removeClass('fixed');
		}  
	});
	
	$('.close_modal_btn').click(function (event) {
		$("#post_modal").hide();
		$('body').removeClass('fixed');
	});	
	
  
});