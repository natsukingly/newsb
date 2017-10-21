
$(document).on('turbolinks:load', function() {
    $(".form_content").height(30);//init
    $(".form_content").css("lineHeight","20px");//init
    
    $(".form_content").on("input",function(evt){
            console.log("comment");
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
