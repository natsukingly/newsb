

var $object = $('.sidebar_wrapper');
var scrollVolume = $(window).scrollTop();
var windowWidth = $(window).width();
var noticeHeight = parseInt($('.notice_bar').css("height"), 10);
var articleHeight = parseInt($('#featured_article_wrapper').css("height"), 10);
var selectedArticleHeight = parseInt($('#selected_article').css("height"));
var offsetAmount = 52;

setTimeout(function(){
    var position = $('#sidebar_left').offset();
	$('.sidebar_wrapper').css("left", position.left);
},2000);

// if(noticeHeight){
// 	offsetAmount += noticeHeight;
// }

if(articleHeight){
	offsetAmount += articleHeight;
}
if(selectedArticleHeight){
	offsetAmount += selectedArticleHeight;
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
	var selectedArticleHeight = parseInt($('#selected_article').css("height"));
    var $object = $('.sidebar_wrapper');
	var scrollVolume = $(window).scrollTop();
	var windowWidth = $(window).width();
	var noticeHeight = parseInt($('.notice_bar').css("height"), 10);
	var articleHeight = parseInt($('#featured_article_wrapper').css("height"), 10);
	var offsetAmount = 58;
	
	
	// if(noticeHeight){
	// 	offsetAmount += noticeHeight;
	// }
	if(articleHeight){
		offsetAmount += articleHeight;
	}
	if(selectedArticleHeight){
		offsetAmount += selectedArticleHeight;
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
			$('#header_nav').css("position", "fixed").css("top", "0").css("right", "0").css("left", "0");
			$('header').css("margin-bottom", navHeight);
		} else {
			$('#header_nav').css("position", "static");
			$('header').css("margin-bottom", "0");
		}
	} else{
		// if(scrollVolume > mobileHeaderHeight){
		// 	$('#header_nav').css("position", "fixed").css("top", "0").css("right", "0").css("left", "0");
		// 	$('#mobile_header').css("margin-bottom", navHeight);
		// } else {
		// 	$('#header_nav').css("position", "static");
		// 	$('#mobile_header').css("margin-bottom", "0");
		// }
	}
});
