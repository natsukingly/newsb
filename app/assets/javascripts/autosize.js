
$(document).on('turbolinks:load', function() {
    $(".form_content").height(30);//init
    $(".form_content").css("lineHeight","20px");//init
    
    $(".form_content").on("input",function(evt){
    		if(evt.target.scrollHeight > evt.target.offsetHeight){
    				$(evt.target).height(evt.target.scrollHeight);
    		}else{
    				var lineHeight = Number($(evt.target).css("lineHeight").split("px")[0]);
    				while (true){
    						$(evt.target).height($(evt.target).height() - lineHeight);
    						if(evt.target.scrollHeight > evt.target.offsetHeight){
    								$(evt.target).height(evt.target.scrollHeight);
    						}
    						break;
    				}
    		}
    });
	$(".post_textarea_block textarea").height(30);//init
	$(".post_textarea_block textarea").css("lineHeight","20px");//init
	
	$(".post_textarea_block textarea").on("input",function(evt){
	    if(evt.target.scrollHeight > evt.target.offsetHeight){
	        $(evt.target).height(evt.target.scrollHeight);
	    }else{
	        var lineHeight = Number($(evt.target).css("lineHeight").split("px")[0]);
	        while (true){
	            $(evt.target).height($(evt.target).height() - lineHeight);
	            if(evt.target.scrollHeight > evt.target.offsetHeight){
	                $(evt.target).height(evt.target.scrollHeight);
	            }
	            break;
	        }
	    }
	});    
			

});
