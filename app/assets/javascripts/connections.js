$(document).ready(function(){
	$("a.optyn_btn").click(function(event){
		var shopId = $(this).data("shop");
		var shopName = $(this).data("shop_name")
		var self = this;
		$.ajax({
		  type: 'POST',
		  dataType: "json",
		  url: "/connections/add_connection",  
		  data:{shop_id:shopId, shop_name:shopName} ,
		  
		  success: function(data) { 
		    if(data.success == false)
		    	alert(data.error_message);	
		    $(self).text(data.success_text);
		    if(data.followed == false)
		    	{
		    		$('#all_connections_table tbody:last').append($(self).parent().parent());
		      	$(self).parent().parent().remove();
		      	$(".flash_message_disconnected").text("You unfollowed " + shopName);
		    	}
		    else 
		    	if(data.followed == true)
		    		{$('#my_connections_table tbody:last').append($(self).parent().parent());
		    	  $(self).parent().parent().remove();
		    		$(".flash_message_connected").text("You are now connected to " + shopName);}
		 	}
		});	
		event.preventDefault();
	});

	$("a.optyn_btn").hover(
    function () {
    	if($(this).attr('data-status') == 'Following')
        {$(this).text('Unfollow');}
    },
    function () {
    	if($(this).attr('data-status') == 'Following')
        {$(this).text('Following');
    }
    }
	);

	$(".open-shopDialog").click(function(){ // Click to only happen on more info links
	 $('#shopDialog').modal('show');
	});

});
