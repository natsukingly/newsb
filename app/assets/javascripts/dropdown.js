$('#mobile_post_link').click(function () {
	$(".ddm").hide();
	$('#mobile_post_ddm').show();
	$('body').addClass('fixed');
	return false;
});


$('.close_ddm_btn').click(function (event) {
	$('#mobile_post_ddm').hide();
	$('body').removeClass('fixed');
});