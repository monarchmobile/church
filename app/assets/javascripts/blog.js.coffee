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
			ChangeDateOnTheFly.init($(this), "start", "blog")

		# ends at date
		$(".blog_message_ends_at").datepicker(dateFormat: "dd-mm-yy")
		$("body").delegate ".blog_message_ends_at", "click", ->
			$(this).datepicker(dateFormat: "dd-mm-yy")

		$("body").delegate ".blog_message_ends_at", "change", ->
			ChangeDateOnTheFly.init($(this), "end", "blog")

	# blogs/edit || blogs/new
	if $('body.blogs_edit').length > 0 || $('body.blogs_new').length > 0
		
		# hide schedule container if current state is draft on page load
		HideShowScheduleContainer.init("blog")

		# select current_state
		$("body").delegate "select#blog_current_state", "change", ->
			value = $(this).val()
			ChangeSubmitText.init(value)

		# date format
		$("#blog_starts_at").datepicker(dateFormat: "dd-mm-yy")
		$("#blog_ends_at").datepicker(dateFormat: "dd-mm-yy")

		# dynamically change dropdown, submit button text and date validation
		$("body").delegate "#blog_starts_at", "change", ->
			start_date = $(this).val()
			end_date = $("#blog_ends_at").val()
			CalculateDate.init(start_date, end_date, "start", "blog")

		$("body").delegate "#blog_ends_at", "change", ->
			start_date = $("#blog_starts_at").val()
			end_date = $(this).val()
			CalculateDate.init(start_date, end_date, "end", "blog")
