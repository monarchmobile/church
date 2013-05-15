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


	$("body").delegate ".add_your_church span", "click", ->
		$this = $(this)
		if $this.parent().next().is(":visible")
	    $this.parent().next().addClass "hidden"
	  else if $this.parent().next().is(":hidden")
	  	$this.parent().next().removeClass "hidden"
	  	$("select#prayer_affiliation").val("")

	$("body").delegate "select#prayer_affiliation", "change", ->
		if $(this).val() is ""
			$("#new_church_name").show()
		else
			$("#new_church_name").hide()

	
	
   

 
    

