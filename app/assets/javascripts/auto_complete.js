
$(document).on('turbolinks:load', function() {
	$('.post_textarea_block.still textarea').keydown(function(e) {
		var $target_form = $(this).parents('.post_form');
		if(e.keyCode === 13){
			if($target_form.find('.autocomplete_tags_block li').length){
				return false;
			}
		}
		if(e.keyCode === 38){
			if($target_form.find('.autocomplete_tags_block li').length){
				return false;
			}
		}
	});
	
	// selecting tags through autocomplete_tag_lists
	$('.post_textarea_block.still textarea').keyup(function(e) {
		var $target_form = $(this).parents('.post_form');
		var $selected_tag = $target_form.find('.suggested_tags li.selected');
		var last_index = $target_form.find('.suggested_tags li').length - 1;
		var selected_index = $selected_tag.index();
		// up
		if(e.keyCode === 38) {
			$selected_tag.removeClass("selected");
			console.log("up");
			if(selected_index == 0){
				 $target_form.find('.suggested_tags li').eq(-1).addClass("selected");
				return false;
			} else{
				selected_index = selected_index - 1;
				 $target_form.find('.suggested_tags li').eq(selected_index).addClass("selected");
				return false;
			}
		// down
		} else if(e.keyCode === 40){
			$selected_tag.removeClass("selected");
			if(selected_index == last_index){
				selected_index = 0;
				$target_form.find('.suggested_tag').eq(selected_index).addClass("selected");
				return false;
			} else{
				selected_index = selected_index + 1;
				 $target_form.find('.suggested_tag').eq(selected_index).addClass("selected");
				return false;
			}
		// enter
		} else if(e.keyCode === 13){
			if($target_form.find('.autocomplete_tags_block li').length){
				var $clicked_tag = $target_form.find('.suggested_tag.selected').text();
				var $old_value = $target_form.find('textarea').val().match(/\S+|\s/g);
				$old_value.pop();
				$old_value.push($clicked_tag);
				$new_value = $old_value.join("") + " ";
				$target_form.find('textarea').val($new_value);
				$target_form.find('textarea').focus();
				$('.autocomplete_tags_block').html(" ");
			}
			return false;
		} 
		
		//collecting suggested tags through ajax
        var hashtag = /[#|＃]\w*[一-龠_ぁ-ん_ァ-ヴーａ-ｚＡ-Ｚa-zA-Z0-9]+|[#|＃]\[a-zA-Z0-9_]+|[#|＃]\[a-zA-Z0-9_]/
		var test = /#\w+/
		var input = $(this).val().split(" ");
		var last_word = input[input.length - 1].replace(/(\r\n|\n|\r)/gm,"");
		var form = $target_form.attr('data-form');
		var country_id = $target_form.attr('data-country');
		if( hashtag.test(last_word) && last_word.length > 2){
			$.ajax({
				url: "https://news-party-natsukingly.c9users.io/" + country_id + "/posts/autocomplete_tags",
				type: "GET",
				data: {input : last_word,
					form: form,
					country_id: country_id,
				},
				dataType: 'script',
			}).fail(function(jqXHR, textStatus, errorThrown) {
				$('.autocomplete_tags_block').html(" ");
			})
			return false;
		} 
		$('.autocomplete_tags_block').html(" ");
		return false;
	});
});
