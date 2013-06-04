jQuery ->
	# announcement/index
	if $('body.announcements_index').length > 0
		#select current_state
		$("body").delegate ".announcement_ajax_edit select", "change", ->
			$(this).closest("form").unbind('submit').submit()

		# sort announcements
		if $("#published_announcements")[0]
			$("#published_announcements").sortable
		    axis: "y"
		    handle: ".handle" 
		    update: ->
		      $.post $(this).data("update-url"), $(this).sortable("serialize")

	  # starts at date
		$(".announcement_message_starts_at").datepicker(dateFormat: "dd-mm-yy")
		$("body").delegate ".announcement_message_starts_at", "click", ->
			$(this).datepicker(dateFormat: "dd-mm-yy")

		$("body").delegate ".announcement_message_starts_at", "change", ->
			ChangeDateOnTheFly.init($(this), "start", "announcement")

		# ends at date
		$(".announcement_message_ends_at").datepicker(dateFormat: "dd-mm-yy")
		$("body").delegate ".announcement_message_ends_at", "click", ->
			$(this).datepicker(dateFormat: "dd-mm-yy")

		$("body").delegate ".announcement_message_ends_at", "change", ->
			ChangeDateOnTheFly.init($(this), "end", "announcement")

	# announcements/edit || announcements/new
	if $('body.announcements_edit').length > 0 || $('body.announcements_new').length > 0
		# hide schedule container if current state is draft on page load
		HideShowScheduleContainer.init("announcement")

		# select current_state
		$("body").delegate "select#announcement_current_state", "change", ->
			value = $(this).val()
			ChangeSubmitText.init(value)

		# date format
		$("#announcement_starts_at").datepicker(dateFormat: "dd-mm-yy")
		$("#announcement_ends_at").datepicker(dateFormat: "dd-mm-yy")

		# dynamically change dropdown, submit button text and date validation
		$("body").delegate "#announcement_starts_at", "change", ->
			start_date = $(this).val()
			end_date = $("#announcement_ends_at").val()
			CalculateDate.init(start_date, end_date, "start", "announcement")

		$("body").delegate "#announcement_ends_at", "change", ->
			start_date = $("#announcement_starts_at").val()
			end_date = $(this).val()
			CalculateDate.init(start_date, end_date, "end", "announcement")

