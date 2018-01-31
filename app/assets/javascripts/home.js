$(document).on('turbolinks:load', function() {
	$('.open_general_mobile_menu').click(function(){
		$('.header_general_menu_right').css("display", "flex");
		$('.open_general_mobile_menu').hide();
		$('.close_general_mobile_menu').show();
	});
	
	$('.close_general_mobile_menu').click(function(){
		$('.header_general_menu_right').hide();
		$('.open_general_mobile_menu').show();
		$('.close_general_mobile_menu').hide();
	});	
});	
	