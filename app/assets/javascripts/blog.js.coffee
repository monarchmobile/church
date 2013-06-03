jQuery ->
	# blog/index
	if $('body.blogs_index').length > 0
		# select status
		$("body").delegate ".blog_ajax_edit select", "change", ->
			$(this).closest("form").unbind('submit').submit()

		# sort blogs
		if $("#published_blogs")[0]
			$("#published_blogs").sortable
	    axis: "y"
	    handle: ".handle"
	    update: ->
	      $.post $(this).data("update-url"), $(this).sortable("serialize")

	  # starts at date
		$(".blog_message_starts_at").datepicker(dateFormat: "dd-mm-yy")
		$("body").delegate ".blog_message_starts_at", "click", ->
			$(this).datepicker(dateFormat: "dd-mm-yy")

		$("body").delegate ".blog_message_starts_at", "change", ->
			$(this).closest("form").unbind('submit').submit()
			value = $(this).val()
			id_attr = $(this).parent().next().attr("id")
			id_array = id_attr.split("_")
			id = id_array[1]
			$("#message_"+id+"_starts_at_text").html(value)
			$(".blog_message_starts_at").datepicker(dateFormat: "dd-mm-yy")

		# ends at date
		$(".blog_message_ends_at").datepicker(dateFormat: "dd-mm-yy")
		$("body").delegate ".blog_message_ends_at", "click", ->
			$(this).datepicker(dateFormat: "dd-mm-yy")

		$("body").delegate ".blog_message_ends_at", "change", ->
			$(this).closest("form").unbind('submit').submit()
			value = $(this).val()
			id_attr = $(this).parent().next().attr("id")
			id_array = id_attr.split("_")
			id = id_array[1]
			$("#message_"+id+"_ends_at_text").html(value)
			$(".blog_message_ends_at").datepicker(dateFormat: "dd-mm-yy")

	# blogs/edit || blogs/new
	if $('body.blogs_edit').length > 0 || $('body.blogs_new').length > 0
		# hide schedule container if current state is draft on page load
		$(".schedule_container").hide() if $("select#blog_current_state option").first().attr("selected") == "selected"

		# select current_state
		$("body").delegate "select#blog_current_state", "change", ->
			if $(this).val() == "1"
				$("input[type=submit]").val("Save Draft")
				$(".schedule_container").hide()
			if $(this).val() == "2"
				$("input[type=submit]").val("Schedule For")
				$(".schedule_container").show()
			else if $(this).val() == "3"
				$("input[type=submit]").val("Publish Now")
				$(".schedule_container").hide()

		# date format
		$("#blog_starts_at").datepicker(dateFormat: "dd-mm-yy")
		$("#blog_ends_at").datepicker(dateFormat: "dd-mm-yy")

		# dynamically change dropdown, submit button text and date validation
		$("body").delegate "#blog_starts_at", "change", ->
			start_date = $(this).val()
			end_date = $("#blog_ends_at").val()
			CalculateDate.init(start_date, end_date, "start", "blog")

		$("body").delegate "#blog_starts_at", "click", ->
			start_date = $(this).val()
			end_date = $("#blog_ends_at").val()
			CalculateDate.init(start_date, end_date, "start", "blog")

		$("body").delegate "#blog_ends_at", "change", ->
			start_date = $("#blog_starts_at").val()
			end_date = $(this).val()
			CalculateDate.init(start_date, end_date, "end", "blog")

		$("body").delegate "#blog_ends_at", "click", ->
			start_date = $("#blog_starts_at").val()
			end_date = $(this).val()
			CalculateDate.init(start_date, end_date, "end", "blog")
