jQuery ->
	# uaffiliation approval status
	$("body").delegate ".affiliation_ajax_edit .affiliation_approval_status", "click", ->
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