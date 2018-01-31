$(document).on('turbolinks:load', function() {
	

	
	
	
	
	
	// $('#mobile_post_link').click(function () {
	// 	$(".ddm").hide();
	// 	$('#mobile_post_ddm').show();
	// 	$('body').addClass('fixed');
	// 	$('.flex_container').hide();
	// 	return false;
	// });
	$('.ddm').click(function(e){
		// e.stopPropagation();
	});
	// mobile_drop_down
	$('#mobile_menu_link').click(function () {
		initializeModal();
		$('.mobile_menu_ddm').show();
		return false;
	});	
	
		
	$('#mobile_locale_link').click(function () {
		initializeModal();
		$('.mobile_locale_ddm').show();
		return false;
	});
	
	$('#mobile_notification_link').click(function () {
		initializeModal();
		$('.mobile_notification_ddm').show();
		return false;
	});
	
	// $('.close_ddm_btn').click(function (event) {
	// 	$('#mobile_post_ddm').hide();
	// 	$('body').removeClass('fixed');
	// });

	$('.close_mobile_ddm_btn').click(function(){
		$(".modal_wrapper, .ddm, .mobile_ddm_header").hide();
		$('.flex_container').show();
		$('html').removeClass('stretch');
		position = $('.mobile_ddm_wrapper').attr('data-position');
		$(window).scrollTop(position);
	});
	$('#mobile_profile_option_link').click(function () {
		initializeModal();
		$('.mobile_profile_option_ddm').show();
		return false;
	});
	
	function initializeModal(){
		position = $(window).scrollTop();
		$('.mobile_ddm_wrapper').attr('data-position', position);
		$(".modal_wrapper, .ddm, .mobile_ddm_header").hide();
		$('.flex_container').hide();
		// $('html').addClass('stretch');
	}	
});