$(window).scroll(function() {
    var object = $('.sidebar_wrapper');
	var scrollVolume = $(window).scrollTop();
	var offsetAmount = 50 + 62;

	if(scrollVolume > offsetAmount){
		$(object).css("top", "40px");
		$(object).css("position", "fixed");
		
		var position = $('#sidebar_left').offset();
		$('object').css("left", position.left);
		
		
		$(window).resize(function() {
			var position = $('#sidebar_left').offset();
			$(object).css("left", position.left);
		});
		
	} else {
		$(object).css("position", "static");
	}
});



$(window).scroll(function() {
	var scrollVolume = $(window).scrollTop();
	var windowWidth = $(window).width();
	var headerHeight = $('header').height();
	var mobileHeaderHeight = $('#mobile_header').height();
	var navHeight = $('#header_nav').height();

	if(windowWidth >= 768){
		if(scrollVolume > headerHeight){
			$('#header_nav').css("position", "fixed").css("right", "0").css("left", "0");
			$('.flex_wrapper').css("margin-top", navHeight);
			$('.user_profile_wrapper').css("margin-top", navHeight);
			
		} else {
			$('#header_nav').css("position", "static");
			$('.flex_wrapper').css("margin-top", "0");
			$('.user_profile_wrapper').css("margin-top", "0");
		}
	} else{
		if(scrollVolume > mobileHeaderHeight){
			$('#header_nav').css("position", "fixed").css("right", "0").css("left", "0");
			$('.flex_wrapper').css("margin-top", navHeight);
			
		} else {
			$('#header_nav').css("position", "static");
			$('.flex_wrapper').css("margin-top", "0");
		}
	}
});
