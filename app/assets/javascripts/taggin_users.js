$(document).on('turbolinks:load', function() {
    
    var tagged_user_ids = []
    var tagged_mode = "default"
    // for article post =========================================
    $('.post_form.for_article_post').on("click",".user_sm", function(){
        if(tagged_mode != "for_article_post"){
            tagged_user_ids = [];
        }
        tagged_mode = "for_article_post";
        console.log(tagged_mode);
    	var tagged_user_id = $(this).attr('data-user-id');
    	
    	console.log(tagged_user_id);
    	var tagged_user_count = tagged_user_ids.length;
    	
    	if(tagged_user_count > 4 && $(this).hasClass('selected') == false){
    		$('.error_message.too_many_tagged_users').show();
    	} else{
    		$('.error_message.too_many_tagged_users').hide();
    		if(tagged_user_ids.includes(tagged_user_id)){
    			for(i=0; i<tagged_user_ids.length; i++){
    				if(tagged_user_ids[i] == tagged_user_id){
    					tagged_user_ids.splice(i, 1);
    				}
    			}
    			
    			$(this).find('.user_add_icon').text("+");
    			$(this).removeClass('selected');
    		} else{
    			tagged_user_ids.push(tagged_user_id);
    			$(this).find('.user_add_icon').text("-");
    			$(this).addClass('selected');
    		}
    		$('input.tagged_user_ids').val(tagged_user_ids);
    	}
    	
    	tagged_user_count = tagged_user_ids.length;
    	$('span.tagged_user_counter').text(tagged_user_count);
    	$('span.tagged_user_counter_on_menu').text(tagged_user_count);
    	
    	if(tagged_user_count == 0){
    		$('.tagged_user_reset_btn').removeClass('on');
    		$('span.tagged_user_counter_on_menu').hide();
    	} else{
    		$('.tagged_user_reset_btn').addClass('on');
    		$('span.tagged_user_counter_on_menu').show();
    	}
    	console.log(tagged_user_ids);
    	var flag = false;
    }); 
    
    
    $('.post_form.from_url').on("click",".user_sm", function(){
        if(tagged_mode != "from_url"){
            tagged_user_ids = [];
        }
        tagged_mode = "from_url";
        
    	var tagged_user_id = $(this).attr('data-user-id');
    	console.log(tagged_user_id);
    	var tagged_user_count = tagged_user_ids.length;
    	
    	if(tagged_user_count > 4 && $(this).hasClass('selected') == false){
    		$('.error_message.too_many_tagged_users').show();
    	} else{
    		$('.error_message.too_many_tagged_users').hide();
    		if(tagged_user_ids.includes(tagged_user_id)){
    			for(i=0; i<tagged_user_ids.length; i++){
    				if(tagged_user_ids[i] == tagged_user_id){
    					tagged_user_ids.splice(i, 1);
    				}
    			}
    			
    			$(this).find('.user_add_icon').text("+");
    			$(this).removeClass('selected');
    		} else{
    			tagged_user_ids.push(tagged_user_id);
    			$(this).find('.user_add_icon').text("-");
    			$(this).addClass('selected');
    		}
    		$('input.tagged_user_ids').val(tagged_user_ids);
    	}
    	
    	tagged_user_count = tagged_user_ids.length;
    	$('span.tagged_user_counter').text(tagged_user_count);
    	$('span.tagged_user_counter_on_menu').text(tagged_user_count);
    	
    	if(tagged_user_count == 0){
    		$('.tagged_user_reset_btn').removeClass('on');
    		$('span.tagged_user_counter_on_menu').hide();
    	} else{
    		$('.tagged_user_reset_btn').addClass('on');
    		$('span.tagged_user_counter_on_menu').show();
    	}
    	console.log(tagged_user_ids);
    	var flag = false;
    });   

    $('.post_form.to_edit').on("click",".user_sm", function(){
    	if(tagged_mode != "to_edit:" + $(this).parents('.post').attr('data-post-id')){
    		var tagged_users = $(this).parents('.user_list_section').find('.selected_user_list').attr('data-tagged-users');
    		console.log(tagged_users);
			if(tagged_users.match(/,/) == null){
    			tagged_user_ids = [];
    			tagged_user_ids.push(tagged_users);
			}else{
				tagged_user_ids = tagged_users.split(',');
			}
    	}
    	console.log(tagged_user_ids);
    	console.log(tagged_user_ids[1]);
        tagged_mode = "to_edit:" + $(this).parents('.post').attr('data-post-id');
    	var tagged_user_id = $(this).attr('data-user-id');
    	console.log(tagged_user_id);
    	var tagged_user_count = tagged_user_ids.length;
    	
    	if(tagged_user_count > 4 && $(this).hasClass('selected') == false){
    		$('.error_message.too_many_tagged_users').show();
    	} else{
    		$('.error_message.too_many_tagged_users').hide();
    		if(tagged_user_ids.includes(tagged_user_id)){
    			for(i=0; i<tagged_user_ids.length; i++){
    				if(tagged_user_ids[i] == tagged_user_id){
    					tagged_user_ids.splice(i, 1);
    				}
    			}
    			
    			$(this).find('.user_add_icon').text("+");
    			$(this).removeClass('selected');
    		} else{
    			tagged_user_ids.push(tagged_user_id);
    			$(this).find('.user_add_icon').text("-");
    			$(this).addClass('selected');
    		}
    		$('input.tagged_user_ids').val(tagged_user_ids);
    	}
    	
    	tagged_user_count = tagged_user_ids.length;
    	$('span.tagged_user_counter').text(tagged_user_count);
    	$('span.tagged_user_counter_on_menu').text(tagged_user_count);
    	
    	if(tagged_user_count == 0){
    		$('.tagged_user_reset_btn').removeClass('on');
    		$('span.tagged_user_counter_on_menu').hide();
    	} else{
    		$('.tagged_user_reset_btn').addClass('on');
    		$('span.tagged_user_counter_on_menu').show();
    	}
    	console.log(tagged_user_ids);
    	var flag = false;
    });   
    
    
	$('.tag_user_btn.form_btn span.closed').click(function(){
		var $form = $(this).parents('.post_form');
		$form.find('.user_search_block').css("display", "flex");
		$form.find('.article_post_content').blur();
		$(this).hide();
		$form.find('.tag_user_btn.form_btn span.opened').css("display", "flex");
		$form.find('.post_submit_btn').addClass("disabled");
	});	
	
	$('.tag_user_btn.form_btn span.opened').click(function(){
		var $form = $(this).parents('.post_form');
		$form.find('.user_search_block').hide();
		$form.find('.user_search_by_name').blur();
		$(this).hide();		
		$form.find('.tag_user_btn.form_btn span.closed').css("display", "flex");
		$form.find('.post_submit_btn').removeClass("disabled");
	});   
	
	$('.tagged_user_reset_btn').click(function(){
		$('.error_message.too_many_tagged_users').hide();
		tagged_user_ids = []
		$('.user_add_icon').text("+");
		$('.user_sm').removeClass('selected');
		$('.tagged_user_reset_btn').removeClass('on');
		tagged_user_count = tagged_user_ids.length;
		$('span.tagged_user_counter').text(tagged_user_count);
		$('span.tagged_user_counter_on_menu').text(tagged_user_count);
		if(tagged_user_count == 0){
			$('span.tagged_user_counter_on_menu').hide();	
		}
		$('input.tagged_user_ids').val(tagged_user_ids);
	});    

	$('.post_form').submit(function(){
		console.log('submit-attempt');
		var tagMode = $(this).find('.tag_user_btn.form_btn span.opened').css("display") == "flex"
		if(tagMode){
			return false;
		}
	});    
	
});
    