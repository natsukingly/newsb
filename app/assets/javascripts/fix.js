

var $object = $('.sidebar_wrapper');
var scrollVolume = $(window).scrollTop();
var windowWidth = $(window).width();
var noticeHeight = parseInt($('.notice_bar').css("height"), 10);
var offsetAmount = 58;

setTimeout(function(){
    var position = $('#sidebar_left').offset();
	$('.sidebar_wrapper').css("left", position.left);
},2000);

if(noticeHeight){
	offsetAmount += noticeHeight;
}

if( $object.length && scrollVolume > offsetAmount){
	$object.css("top", "40px").css("position", "fixed").css("width", "200px");
	
	var position = $('#sidebar_left').offset();
	$object.css("left", position.left);
	
	
	$(window).resize(function() {
		var position = $('#sidebar_left').offset();
		$object.css("left", position.left);
	});
	
} else {
	$object.css("position", "static");
}

$(window).scroll(function() {
	
    var $object = $('.sidebar_wrapper');
	var scrollVolume = $(window).scrollTop();
	var windowWidth = $(window).width();
	var noticeHeight = parseInt($('.notice_bar').css("height"), 10);
	var offsetAmount = 58;
	
	if(noticeHeight){
		offsetAmount += noticeHeight;
	}
	
	if( $object.length && scrollVolume > offsetAmount){
		$object.css("top", "40px").css("position", "fixed").css("width", "200px");
		
		var position = $('#sidebar_left').offset();
		$object.css("left", position.left);
		
		
		$(window).resize(function() {
			var position = $('#sidebar_left').offset();
			$object.css("left", position.left);
		});
		
	} else {
		$object.css("position", "static");
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
			$('.flex_wrapper.on_user_profile').css("margin-top", "0");
			$('#user_profile_wrapper').css("margin-top", navHeight);
			
		} else {
			$('#header_nav').css("position", "static");
			$('.flex_wrapper').css("margin-top", "0");
			$('#user_profile_wrapper').css("margin-top", "0");
		}
	} else{
		if(scrollVolume > mobileHeaderHeight){
			$('#header_nav').css("position", "fixed").css("right", "0").css("left", "0");
			$('.flex_wrapper').css("margin-top", navHeight);
			$('.flex_wrapper.on_user_profile').css("margin-top", "0");
			$('#user_profile_wrapper').css("margin-top", navHeight);
			
		} else {
			$('#header_nav').css("position", "static");
			$('.flex_wrapper').css("margin-top", "0");
			$('#user_profile_wrapper').css("margin-top", "0");
		}
	}
});
