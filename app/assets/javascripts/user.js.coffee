jQuery ->
	

	# user approval status
	$("body").delegate ".user_ajax_edit .user_approval_status", "change", ->
		select = $(this).prev()
		if select.val() == "true"
			select.val("false")
			console.log(select.val())
			select.closest("form").submit()
			$(this).html("Not Approved").removeClass("green_background").addClass("red_background")
		else if select.val() == "false"
			select.val("true")
			select.closest("form").submit()
			$(this).html("Approved").addClass("green_background").removeClass("red_background")

	# user approval status
	$("body").delegate ".user_ajax_edit .user_approval_status", "click", ->
		select = $(this).prev()
		if select.val() == "true"
			select.val("false")
			console.log(select.val())
			select.closest("form").submit()
			$(this).html("Not Approved").removeClass("green_background").addClass("red_background")
		else if select.val() == "false"
			select.val("true")
			select.closest("form").submit()
			$(this).html("Approved").addClass("green_background").removeClass("red_background")

	$("body").delegate ".add_your_church span", "click", ->
	  $this = $(this)
	  if $this.parent().next().is(":visible")
	    console.log "hidden"
	    $this.parent().next().addClass "hidden"
	  else if $this.parent().next().is(":hidden")
	    console.log "showing"
	    $this.parent().next().removeClass "hidden"
	    $("select#user_affiliation").val ""

	$("body").delegate "select#user_affiliation", "change", ->
		if $(this).val() is ""
			$("#new_church_name").removeClass "hidden"
		else
			$("#new_church_name").addClass "hidden"

		