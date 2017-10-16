$(window).scroll(function() {
    var object = $('.sidebar_wrapper');
	var scrollVolume = $(window).scrollTop();
	var offsetAmount = 50 + 62;

	if(scrollVolume > offsetAmount){
		console.log("yo");
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