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


	$("body").delegate ".new_prayer .add_your_church em span", "click", ->
	  $this = $(this)
	  if $this.closest(".add_your_church").next().is(":visible")
	    console.log "hidden"
	    $this.closest(".add_your_church").next().addClass "hidden"
	  else if $this.closest(".add_your_church").next().is(":hidden")
	    console.log "showing"
	    $this.closest(".add_your_church").next().removeClass "hidden"
	    $("select#prayer_affiliation").val ""

	$("body").delegate "select#prayer_affiliation", "change", ->
		if $(this).val() is ""
			$("#new_church_name").removeClass "hidden"
		else
			$("#new_church_name").addClass "hidden"

	
	
   

 
    

