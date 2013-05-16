jQuery ->

	$("body").delegate ".user_ajax_edit .user_approval_status", "click", ->
		$this = $(this).prev()
		if $this.val() is "true"
			$this.val(false)
			$(this).html("Not Approved").removeClass("green_background").addClass("red_background")
			console.log("submit as not approved")
			$this.closest("form").submit()
		else if $this.val() is "false"
			$this.val(true)
			$(this).html("Approved").addClass("green_background").removeClass("red_background")
			console.log("submit as approved")
			$this.closest("form").submit()

	$("body").delegate "#new_user .add_your_church span", "click", ->
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

		