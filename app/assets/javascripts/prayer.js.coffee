jQuery ->
	$("#prayer_user_email").focusout ->
		email = $(this).val()
		URL = "users/search"
		data = {}
		data["email"] = email
		$.ajax
			data: data
			url: URL
			type: "post" 
			success: ->
				



  $(".add_your_church span").click ->
	  if $(".add_your_church span").parent().next().is(":visible")
	    $(".add_your_church span").parent().next().hide()
	  else
	    $(".add_your_church span").parent().next().show()

	
	
   

 
    

