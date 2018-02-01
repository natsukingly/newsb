$(document).on('turbolinks:load', function() {
	$('.scroll_btn.mobile_notifications').click(function(e){
		e.stopPropagation();
		var stop_loading = $(this).hasClass('stop_loading');
		if(!(stop_loading)){
			$.ajax({
				url: "#{load_mobile_notifications_path}",
				type: "GET",
				data: {existing_notifications: $('.mobile_notifications').find('.notification').length,
				},
				dataType: 'script',
			})
			$(this).html("<i class='fa fa-spinner fa-pulse'></i>");
			$(this).addClass("loading");
		}
	});
});