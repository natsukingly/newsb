
$(document).on('turbolinks:load', function() {
    
    $('.cancel_btn').click(function(){
        $(this).parents('.comment_form').hide();
        $(this).parents('.post').find('.invite_comment').show();
    });
    
    $('.comment_link').click(function(){
        console.log("clicked");
    	$(this).parents('.post').find('.comment_form').show();
    	$(this).parents('.post').find('.comment_form textarea').focus();
    	$(this).parents('.post').find('.invite_comment').hide();
    });
    
    // reply
    $('.cancel_btn.cancel_reply').click(function(){
        $(this).parents('.reply_form').html('');
    });
    
    
    // articles/show post_form form_no_category
    $("#post_form .textarea").click(function(){
        console.log("i am aweosme");
       $("#post_content").focus(); 
    });
    
    
    // post ddm open-close
    $('.option').click(function () {
			// ボタンが押されたら、モーダルウィンドウを表示
			$(this).find('.post_ddm').css("display", "flex");
			return false;
	});

	$(document).click(function () {
			// 背景がクリックされたら、ウィンドウを閉じる
			$('.post_ddm').hide();
			return false;
	});

	$('.post_ddm').click(function (event) {
			// ウィンドウの中身をクリックしても、閉じないようにする
			// (親である .windowBg への伝播を止める)
			event.stopPropagation();
	});
    
    
    // locales link open close
    
    $('#locale_link').click(function () {
			// ボタンが押されたら、モーダルウィンドウを表示
			$('#locale_ddm').css("display", "flex");
			return false;
	});

	$(document).click(function () {
			// 背景がクリックされたら、ウィンドウを閉じる
			$('#locale_ddm').hide();
			return false;
	});

	$('#locale_ddm').click(function (event) {
			// ウィンドウの中身をクリックしても、閉じないようにする
			// (親である .windowBg への伝播を止める)
			event.stopPropagation();
	});
    
    
    // $('#locale_close_btn').click(function(){
    //     $('#locale_ddm').hide();
    // });
    
    // $('#locale_link').click(function(){
    // 	$('#locale_ddm').css("display", "flex");
    // });
    
});




